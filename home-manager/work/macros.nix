{
	programs.zsh = {
		shellAliases = {
			"1" = "ssh paissilva@builder3";
			"2" = "ssh dps@projectpc";
			"3" = "ssh labgrid@projectpc";
			"l1" = "source ~/fusion-labgrid/fusion_profile";
			"l2" = "source ~/fusion-labgrid/tfusion_profile";
			"ph" = "cd $PROJECTPC_HOME";
			"bd" = "cd $BUILDER3_DATA";
			"fh" = "cd $FUSION_HOME";
			"vh" = "cd $VISION3_HOME";
			"yocto" = "cd $YOCTO_SOURCES";
			"devtool_home" = "cd $DEVTOOL_SOURCES";
			"deploy_dir" = "cd $DEPLOY_DIR";
			"remount_sshfs" = "systemctl --user restart home-paissilva-mounts-builder3_data.mount && systemctl --user restart home-paissilva-mounts-projectpc_home.mount";
			"todo" = "mkdir -p ~/Documents/notes; vi ~/Documents/notes/todo.md";
		};

		initExtra = ''
			export PROJECTPC_HOME=/home/paissilva/mounts/projectpc_home
			export BUILDER3_DATA=/home/paissilva/mounts/builder3_data
			export FUSION_HOME=$BUILDER3_DATA/fusion
			export VISION3_HOME=$BUILDER3_DATA/vision3

			fusion () {
				export CURRENT_WORKSPACE="fusion"
				export YOCTO_HOME=$FUSION_HOME/yocto
				export YOCTO_HOME=$FUSION_HOME/yocto-fusion
				export YOCTO_SOURCES=$YOCTO_HOME/sources
				export DEVTOOL_SOURCES=$YOCTO_HOME/build/workspace/sources
				export DEPLOY_DIR=$YOCTO_HOME/build/tmp/deploy/images/$CURRENT_WORKSPACE
				
				echo " Workspace set to Fusion"
			}

			vision3 () {
				export CURRENT_WORKSPACE="vision3"
				export YOCTO_HOME=$VISION3_HOME/yocto
				export YOCTO_HOME=$VISION3_HOME/yocto
				export YOCTO_SOURCES=$YOCTO_HOME/sources
				export DEVTOOL_SOURCES=$YOCTO_HOME/build/workspace/sources
				export DEPLOY_DIR=$YOCTO_HOME/build/tmp/deploy/images/$CURRENT_WORKSPACE
				
				echo " Workspace set to Vision3"
			}

			deploy_vision3_usb () {
				if [[ $# -eq 0 ]]; then
					echo "Specify usb stick device"
				fi

				sudo mount -o gid=1769400513,fmask=113,dmask=002 $1 /mnt/ && \
				rm -rf /mnt/vision3updater && \
				cp $DEPLOY_DIR/ttc-image-qt5-target-update.zip /mnt && \
				unzip /mnt/ttc-image-qt5-target-update.zip -d /mnt 
				sudo umount /mnt
			}

			deploy_vision3_qt () {
				scp $VISION3_HOME/qt-hmi/build/libQtHMI.so root@10.100.30.130:/lib/qml/com/hmi/qmlcomponents/libQtHMI.so
				scp $VISION3_HOME/qt5-examples/build/digital-camera/qt5-digital-camera root@10.100.30.130:~/
				scp $VISION3_HOME/qt5-examples/build/camera/qt5-camera root@10.100.30.130:~/
			}

			echo "============================================"
			echo
			fortune | cowsay
			echo
			echo "============================================"
			echo " [1] - paissilva@builder3"
			echo " [2] - dps@projectpc"
			echo " [3] - labgrid@projectpc"
			echo "============================================"
			echo " [fusion] - Change workspace to Fusion"
			echo " [vision3] - Change workspace to Vision3"
			echo "============================================"
			echo " Setups"
			echo " [l1] - Fusion dps"
			echo " [l2] - Fusion tester"
			echo "============================================"
			fusion
			echo "============================================"
			echo
		'';
	};
}
