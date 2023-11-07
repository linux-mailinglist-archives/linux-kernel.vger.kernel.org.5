Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B45A7E497F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjKGUA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjKGUAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:00:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD76E7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:00:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1B2C433C8;
        Tue,  7 Nov 2023 20:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699387250;
        bh=feNeYN4M+KnMMa2vTaOcBUq0QN9COXR/sYWfCgmwGdw=;
        h=From:Date:Subject:To:Cc:From;
        b=qZA5iZzvdIgwSjYMgCCP5XSODokjRKdknHrVtGv5YUhsDtX01GnQi2SazE6O+5Rw+
         kcIz23IkiXdppRmO3ed8LmTsyrXAhYb3ZFkWKxh+ujS/kMdDKUeR2qCyuEGQVCvHVZ
         ITLdgh65WEgfz5x0fbISYZouadOeivIkhtQMuLho=
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Tue, 07 Nov 2023 15:00:32 -0500
Subject: [PATCH] MAINTAINERS: update lists.linuxfoundation.org migrated
 lists
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-lists-lf-org-move-v1-1-b19b499a93fb@linuxfoundation.org>
X-B4-Tracking: v=1; b=H4sIAF+XSmUC/x3MSwqAMAwA0auUrA3YKmq9irjwEzVQW2lEBPHuF
 pdvMfOAUGQSaNUDkS4WDj5BZwqmbfArIc/JYHJTaJ3X6FhOQbdgiCvu4SIc56KuLJmmKS2k7oi
 08P0/u/59P9HFOM1jAAAA
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     virtualization@lists.linux.dev, acpica-devel@lists.linux.dev,
        bridge@lists.linux.dev, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=9498;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=feNeYN4M+KnMMa2vTaOcBUq0QN9COXR/sYWfCgmwGdw=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGFK9phcazwztm/BIdBOLzhqfw/ufPm8tml/X+O3fwfl3L
 8Wu/3B7akcpC4MYF4OsmCJL2b7YTUGFDz3k0ntMYeawMoEMYeDiFICJ9D9m+O+9d1V/l4SHRNME
 wy/izuqskz4L7poQl/e5zXCRV+dJAV6G3+wld64cPxkhtOeExLQMOeagn4sZvR9K3r43d/NbzzP
 x15gB
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mailman-2 system behind lists.linux[-]foundation.org is being
retired, so the lists are being migrated to lists.linux.dev. Since both
domains belong to LF and setting up proper forwards is possible, the old
addresses will continue to work for a while, but all new patches should
be sent to the new canonical addresses for each list.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
Linus:

Normally, these would go through individual subsystems, but it's one of
those one-off changes that don't really bubble up in a natural way. If
you would like to pull this in through someone else's tree, please let
me know to whom I should send this instead.
---
 MAINTAINERS | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5de540ec0b..9f155f96f0ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -309,7 +309,7 @@ ACPI COMPONENT ARCHITECTURE (ACPICA)
 M:	Robert Moore <robert.moore@intel.com>
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
 L:	linux-acpi@vger.kernel.org
-L:	acpica-devel@lists.linuxfoundation.org
+L:	acpica-devel@lists.linux.dev
 S:	Supported
 W:	https://acpica.org/
 W:	https://github.com/acpica/acpica/
@@ -6453,7 +6453,7 @@ F:	drivers/gpu/drm/ast/
 
 DRM DRIVER FOR BOCHS VIRTUAL GPU
 M:	Gerd Hoffmann <kraxel@redhat.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/tiny/bochs.c
@@ -6699,7 +6699,7 @@ F:	drivers/gpu/drm/tiny/repaper.c
 DRM DRIVER FOR QEMU'S CIRRUS DEVICE
 M:	Dave Airlie <airlied@redhat.com>
 M:	Gerd Hoffmann <kraxel@redhat.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Obsolete
 W:	https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -6708,7 +6708,7 @@ F:	drivers/gpu/drm/tiny/cirrus.c
 DRM DRIVER FOR QXL VIRTUAL GPU
 M:	Dave Airlie <airlied@redhat.com>
 M:	Gerd Hoffmann <kraxel@redhat.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 L:	spice-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -7775,7 +7775,7 @@ F:	drivers/net/can/usb/etas_es58x/
 ETHERNET BRIDGE
 M:	Roopa Prabhu <roopa@nvidia.com>
 M:	Nikolay Aleksandrov <razor@blackwall.org>
-L:	bridge@lists.linux-foundation.org (moderated for non-subscribers)
+L:	bridge@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.linuxfoundation.org/en/Net:Bridge
@@ -16194,7 +16194,7 @@ M:	Juergen Gross <jgross@suse.com>
 R:	Ajay Kaher <akaher@vmware.com>
 R:	Alexey Makhalov <amakhalov@vmware.com>
 R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
@@ -22734,7 +22734,7 @@ VIRTIO AND VHOST VSOCK DRIVER
 M:	Stefan Hajnoczi <stefanha@redhat.com>
 M:	Stefano Garzarella <sgarzare@redhat.com>
 L:	kvm@vger.kernel.org
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
@@ -22746,7 +22746,7 @@ F:	net/vmw_vsock/virtio_transport_common.c
 VIRTIO BALLOON
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	David Hildenbrand <david@redhat.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/virtio/virtio_balloon.c
 F:	include/linux/balloon_compaction.h
@@ -22758,7 +22758,7 @@ M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/block/virtio_blk.c
 F:	drivers/scsi/virtio_scsi.c
@@ -22767,7 +22767,7 @@ F:	include/uapi/linux/virtio_scsi.h
 
 VIRTIO CONSOLE DRIVER
 M:	Amit Shah <amit@kernel.org>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/char/virtio_console.c
 F:	include/linux/virtio_console.h
@@ -22777,7 +22777,7 @@ VIRTIO CORE AND NET DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-vdpa
 F:	Documentation/ABI/testing/sysfs-class-vduse
@@ -22796,7 +22796,7 @@ F:	tools/virtio/
 
 VIRTIO CRYPTO DRIVER
 M:	Gonglei <arei.gonglei@huawei.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/virtio/
@@ -22807,7 +22807,7 @@ M:	Cornelia Huck <cohuck@redhat.com>
 M:	Halil Pasic <pasic@linux.ibm.com>
 M:	Eric Farman <farman@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 L:	kvm@vger.kernel.org
 S:	Supported
 F:	arch/s390/include/uapi/asm/virtio-ccw.h
@@ -22817,7 +22817,7 @@ VIRTIO FILE SYSTEM
 M:	Vivek Goyal <vgoyal@redhat.com>
 M:	Stefan Hajnoczi <stefanha@redhat.com>
 M:	Miklos Szeredi <miklos@szeredi.hu>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
 W:	https://virtio-fs.gitlab.io/
@@ -22829,7 +22829,7 @@ VIRTIO GPIO DRIVER
 M:	Enrico Weigelt, metux IT consult <info@metux.net>
 M:	Viresh Kumar <vireshk@kernel.org>
 L:	linux-gpio@vger.kernel.org
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/gpio/gpio-virtio.c
 F:	include/uapi/linux/virtio_gpio.h
@@ -22840,7 +22840,7 @@ M:	Gerd Hoffmann <kraxel@redhat.com>
 R:	Gurchetan Singh <gurchetansingh@chromium.org>
 R:	Chia-I Wu <olvaffe@gmail.com>
 L:	dri-devel@lists.freedesktop.org
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/virtio/
@@ -22850,7 +22850,7 @@ VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 L:	kvm@vger.kernel.org
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
@@ -22866,7 +22866,7 @@ M:	Jason Wang <jasowang@redhat.com>
 M:	Mike Christie <michael.christie@oracle.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/vhost/scsi.c
 
@@ -22874,7 +22874,7 @@ VIRTIO I2C DRIVER
 M:	Conghui Chen <conghui.chen@intel.com>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 L:	linux-i2c@vger.kernel.org
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/i2c/busses/i2c-virtio.c
 F:	include/uapi/linux/virtio_i2c.h
@@ -22887,14 +22887,14 @@ F:	include/uapi/linux/virtio_input.h
 
 VIRTIO IOMMU DRIVER
 M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/iommu/virtio-iommu.c
 F:	include/uapi/linux/virtio_iommu.h
 
 VIRTIO MEM DRIVER
 M:	David Hildenbrand <david@redhat.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 W:	https://virtio-mem.gitlab.io/
 F:	drivers/virtio/virtio_mem.c
@@ -22902,7 +22902,7 @@ F:	include/uapi/linux/virtio_mem.h
 
 VIRTIO PMEM DRIVER
 M:	Pankaj Gupta <pankaj.gupta.linux@gmail.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/nvdimm/nd_virtio.c
 F:	drivers/nvdimm/virtio_pmem.c
@@ -22910,7 +22910,7 @@ F:	drivers/nvdimm/virtio_pmem.c
 VIRTIO SOUND DRIVER
 M:	Anton Yakovlev <anton.yakovlev@opensynergy.com>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	include/uapi/linux/virtio_snd.h
@@ -22968,7 +22968,7 @@ F:	include/linux/vlynq.h
 
 VM SOCKETS (AF_VSOCK)
 M:	Stefano Garzarella <sgarzare@redhat.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/vsockmon.c
@@ -23012,7 +23012,7 @@ VMWARE HYPERVISOR INTERFACE
 M:	Ajay Kaher <akaher@vmware.com>
 M:	Alexey Makhalov <amakhalov@vmware.com>
 R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
-L:	virtualization@lists.linux-foundation.org
+L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vmware

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231107-lists-lf-org-move-bd3769e28849

Best regards,
-- 
Konstantin Ryabitsev <konstantin@linuxfoundation.org>

