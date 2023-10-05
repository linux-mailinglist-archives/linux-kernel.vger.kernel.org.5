Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CD7BAC10
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjJEV3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJEV3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:29:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E28995;
        Thu,  5 Oct 2023 14:29:41 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3958YZvw071452;
        Thu, 5 Oct 2023 03:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696494875;
        bh=XJleEZ4A03CEhkaLfhgHPnNxyzZC5nvdxrMYseBTNTI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=UYk1F4Qp8rJUkjlowmK8sF1VA9XfqutJ1ESBiHWf6pk/31GDW8YOcd1dIYUnFBwUc
         NMO/QJPYbUXfBHGsCWX7+5+eviodXKvu//IBqkwiGhmVYvcjdRqHVz/joEFD09fgDK
         glSFMhsfa5uMXgHszWPGdVWktgsWaAJMidLRIIFg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3958YZdu100232
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Oct 2023 03:34:35 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 03:34:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 03:34:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3958YXHF019511;
        Thu, 5 Oct 2023 03:34:33 -0500
Date:   Thu, 5 Oct 2023 14:04:30 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <a-bhatia1@ti.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: Re: [PATCH v9 13/13] media: ti: Add CSI2RX support for J721E
Message-ID: <2mqfvtgbzoya4jdkjppgagqf2ozgygcj7lautjave7fthiwuhb@b7wdkzpbi6xr>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
 <20230811-upstream_csi-v9-13-8943f7a68a81@ti.com>
 <20230829164457.GH6477@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7jjrsghq242jhmur"
Content-Disposition: inline
In-Reply-To: <20230829164457.GH6477@pendragon.ideasonboard.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--7jjrsghq242jhmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

Thanks for the review, and apologies for being late on getting back on=20
this.

On Aug 29, 2023 at 19:44:57 +0300, Laurent Pinchart wrote:
> Hi Jai,
>=20
> Thank you for the patch.
>=20
> On Fri, Aug 11, 2023 at 04:17:35PM +0530, Jai Luthra wrote:
> > From: Pratyush Yadav <p.yadav@ti.com>
> >=20
> > TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> > capture over a CSI-2 bus.
> >=20
> > The Cadence CSI2RX IP acts as a bridge between the TI specific parts and
> > the CSI-2 protocol parts. TI then has a wrapper on top of this bridge
> > called the SHIM layer. It takes in data from stream 0, repacks it, and
> > sends it to memory over PSI-L DMA.
> >=20
> > This driver acts as the "front end" to V4L2 client applications. It
> > implements the required ioctls and buffer operations, passes the
> > necessary calls on to the bridge, programs the SHIM layer, and performs
> > DMA via the dmaengine API to finally return the data to a buffer
> > supplied by the application.
> >=20
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > Co-authored-by: Vaishnav Achath <vaishnav.a@ti.com>
> > Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> > Tested-by: Vaishnav Achath <vaishnav.a@ti.com>
> > Co-authored-by: Jai Luthra <j-luthra@ti.com>
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > ---
> > Changes since v8:
> >     - Allocate drain buffer at start of stream instead of doing it in t=
he
> >       middle, and document why it is needed in comments
> >     - Call subdev's get_fmt directly for link_validation()
> >     - Cleanup height/width clamping and rounding code, document it in c=
omments
> >     - Return and check errors from setup_shim()
> >     - s/subdev/source for cadence csi2rx's v4l2_subdev
> >     - s/ti_csi2rx_init_subdev/ti_csi2rx_notifier_register
> >     - Change copyright year/author list
> >=20
> >  MAINTAINERS                                        |    7 +
> >  drivers/media/platform/ti/Kconfig                  |   12 +
> >  drivers/media/platform/ti/Makefile                 |    1 +
> >  drivers/media/platform/ti/j721e-csi2rx/Makefile    |    2 +
> >  .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 1150 ++++++++++++=
++++++++
> >  5 files changed, 1172 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 02a3192195af..959147d6d936 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21455,6 +21455,13 @@ F:	Documentation/devicetree/bindings/media/i2c=
/ti,ds90*
> >  F:	drivers/media/i2c/ds90*
> >  F:	include/media/i2c/ds90*
> > =20
> > +TI J721E CSI2RX DRIVER
> > +M:	Jai Luthra <j-luthra@ti.com>
> > +L:	linux-media@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
> > +F:	drivers/media/platform/ti/j721e-csi2rx/
> > +
> >  TI KEYSTONE MULTICORE NAVIGATOR DRIVERS
> >  M:	Nishanth Menon <nm@ti.com>
> >  M:	Santosh Shilimkar <ssantosh@kernel.org>
> > diff --git a/drivers/media/platform/ti/Kconfig b/drivers/media/platform=
/ti/Kconfig
> > index e1ab56c3be1f..42c908f6e1ae 100644
> > --- a/drivers/media/platform/ti/Kconfig
> > +++ b/drivers/media/platform/ti/Kconfig
> > @@ -63,6 +63,18 @@ config VIDEO_TI_VPE_DEBUG
> >  	help
> >  	  Enable debug messages on VPE driver.
> > =20
> > +config VIDEO_TI_J721E_CSI2RX
> > +	tristate "TI J721E CSI2RX wrapper layer driver"
> > +	depends on VIDEO_DEV && VIDEO_V4L2_SUBDEV_API
> > +	depends on MEDIA_SUPPORT && MEDIA_CONTROLLER
> > +	depends on PHY_CADENCE_DPHY_RX && VIDEO_CADENCE_CSI2RX
>=20
> Is there a compile-time dependency on these, or just runtime ? If it's
> just at runtime, it would be nice to either drop the dependency here, or
> add a (...) || COMPILE_TEST
>=20

There isn't a compile-time dependency as such, but yes this IP only=20
works with Cadence CSI+DPHY so I will switch it to (...) ||=20
COMPILE_TEST.

> > +	depends on ARCH_K3 || COMPILE_TEST
> > +	select VIDEOBUF2_DMA_CONTIG
> > +	select V4L2_FWNODE
> > +	help
> > +	  Support for TI CSI2RX wrapper layer. This just enables the wrapper =
driver.
> > +	  The Cadence CSI2RX bridge driver needs to be enabled separately.
> > +
> >  source "drivers/media/platform/ti/am437x/Kconfig"
> >  source "drivers/media/platform/ti/davinci/Kconfig"
> >  source "drivers/media/platform/ti/omap/Kconfig"
> > diff --git a/drivers/media/platform/ti/Makefile b/drivers/media/platfor=
m/ti/Makefile
> > index 98c5fe5c40d6..8a2f74c9380e 100644
> > --- a/drivers/media/platform/ti/Makefile
> > +++ b/drivers/media/platform/ti/Makefile
> > @@ -3,5 +3,6 @@ obj-y +=3D am437x/
> >  obj-y +=3D cal/
> >  obj-y +=3D vpe/
> >  obj-y +=3D davinci/
> > +obj-y +=3D j721e-csi2rx/
> >  obj-y +=3D omap/
> >  obj-y +=3D omap3isp/
> > diff --git a/drivers/media/platform/ti/j721e-csi2rx/Makefile b/drivers/=
media/platform/ti/j721e-csi2rx/Makefile
> > new file mode 100644
> > index 000000000000..377afc1d6280
> > --- /dev/null
> > +++ b/drivers/media/platform/ti/j721e-csi2rx/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_VIDEO_TI_J721E_CSI2RX) +=3D j721e-csi2rx.o
> > diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/dr=
ivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> > new file mode 100644
> > index 000000000000..301d947f6098
> > --- /dev/null
> > +++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> > @@ -0,0 +1,1150 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * TI CSI2RX Shim Wrapper Driver
> > + *
> > + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.=
com/
> > + *
> > + * Author: Pratyush Yadav <p.yadav@ti.com>
> > + * Author: Jai Luthra <j-luthra@ti.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <media/mipi-csi2.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-ioctl.h>
> > +#include <media/v4l2-mc.h>
> > +#include <media/videobuf2-dma-contig.h>
> > +
> > +#define TI_CSI2RX_MODULE_NAME		"j721e-csi2rx"
> > +
> > +#define SHIM_CNTL			0x10
> > +#define SHIM_CNTL_PIX_RST		BIT(0)
> > +
> > +#define SHIM_DMACNTX			0x20
> > +#define SHIM_DMACNTX_EN			BIT(31)
> > +#define SHIM_DMACNTX_YUV422		GENMASK(27, 26)
> > +#define SHIM_DMACNTX_SIZE		GENMASK(21, 20)
> > +#define SHIM_DMACNTX_FMT		GENMASK(5, 0)
> > +#define SHIM_DMACNTX_UYVY		0
> > +#define SHIM_DMACNTX_VYUY		1
> > +#define SHIM_DMACNTX_YUYV		2
> > +#define SHIM_DMACNTX_YVYU		3
> > +#define SHIM_DMACNTX_SIZE_8		0
> > +#define SHIM_DMACNTX_SIZE_16		1
> > +#define SHIM_DMACNTX_SIZE_32		2
> > +
> > +#define SHIM_PSI_CFG0			0x24
> > +#define SHIM_PSI_CFG0_SRC_TAG		GENMASK(15, 0)
> > +#define SHIM_PSI_CFG0_DST_TAG		GENMASK(31, 16)
> > +
> > +#define PSIL_WORD_SIZE_BYTES		16
> > +/*
> > + * There are no hard limits on the width or height. The DMA engine can=
 handle
> > + * all sizes. The max width and height are arbitrary numbers for this =
driver.
> > + * Use 16K * 16K as the arbitrary limit. It is large enough that it is=
 unlikely
> > + * the limit will be hit in practice.
> > + */
> > +#define MAX_WIDTH_BYTES			SZ_16K
> > +#define MAX_HEIGHT_LINES		SZ_16K
> > +
> > +#define DRAIN_TIMEOUT_MS		50
> > +
> > +struct ti_csi2rx_fmt {
> > +	u32				fourcc;	/* Four character code. */
> > +	u32				code;	/* Mbus code. */
> > +	u32				csi_dt;	/* CSI Data type. */
> > +	u8				bpp;	/* Bits per pixel. */
> > +	u8				size;	/* Data size shift when unpacking. */
> > +};
> > +
> > +struct ti_csi2rx_buffer {
> > +	/* Common v4l2 buffer. Must be first. */
> > +	struct vb2_v4l2_buffer		vb;
> > +	struct list_head		list;
> > +	struct ti_csi2rx_dev		*csi;
> > +};
> > +
> > +enum ti_csi2rx_dma_state {
> > +	TI_CSI2RX_DMA_STOPPED,	/* Streaming not started yet. */
> > +	TI_CSI2RX_DMA_IDLE,	/* Streaming but no pending DMA operation. */
> > +	TI_CSI2RX_DMA_ACTIVE,	/* Streaming and pending DMA operation. */
> > +};
> > +
> > +struct ti_csi2rx_dma {
> > +	/* Protects all fields in this struct. */
> > +	spinlock_t			lock;
> > +	struct dma_chan			*chan;
> > +	/* Buffers queued to the driver, waiting to be processed by DMA. */
> > +	struct list_head		queue;
> > +	enum ti_csi2rx_dma_state	state;
> > +	/*
> > +	 * Queue of buffers submitted to DMA engine.
> > +	 */
> > +	struct list_head		submitted;
> > +	/* Buffer to drain stale data from PSI-L endpoint */
> > +	struct {
> > +		void			*vaddr;
> > +		dma_addr_t		paddr;
> > +		size_t			len;
> > +	} drain;
> > +};
> > +
> > +struct ti_csi2rx_dev {
> > +	struct device			*dev;
> > +	void __iomem			*shim;
> > +	struct v4l2_device		v4l2_dev;
> > +	struct video_device		vdev;
> > +	struct media_device		mdev;
> > +	struct media_pipeline		pipe;
> > +	struct media_pad		pad;
> > +	struct v4l2_async_notifier	notifier;
> > +	struct v4l2_subdev		*source;
> > +	struct vb2_queue		vidq;
> > +	struct mutex			mutex; /* To serialize ioctls. */
> > +	struct v4l2_format		v_fmt;
> > +	struct ti_csi2rx_dma		dma;
> > +	u32				sequence;
> > +};
> > +
> > +static const struct ti_csi2rx_fmt formats[] =3D {
>=20
> It would be nice to prefix local symbols to avoid namespace clashes,
> even if they're static. ti_csi2rx_formats could be a good name. Same
> below where applicable, and possibly above for some macro names.
>=20

Will fix.

> > +	{
> > +		.fourcc			=3D V4L2_PIX_FMT_YUYV,
> > +		.code			=3D MEDIA_BUS_FMT_YUYV8_1X16,
> > +		.csi_dt			=3D MIPI_CSI2_DT_YUV422_8B,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_UYVY,
> > +		.code			=3D MEDIA_BUS_FMT_UYVY8_1X16,
> > +		.csi_dt			=3D MIPI_CSI2_DT_YUV422_8B,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_YVYU,
> > +		.code			=3D MEDIA_BUS_FMT_YVYU8_1X16,
> > +		.csi_dt			=3D MIPI_CSI2_DT_YUV422_8B,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_VYUY,
> > +		.code			=3D MEDIA_BUS_FMT_VYUY8_1X16,
> > +		.csi_dt			=3D MIPI_CSI2_DT_YUV422_8B,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SBGGR8,
> > +		.code			=3D MEDIA_BUS_FMT_SBGGR8_1X8,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW8,
> > +		.bpp			=3D 8,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SGBRG8,
> > +		.code			=3D MEDIA_BUS_FMT_SGBRG8_1X8,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW8,
> > +		.bpp			=3D 8,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SGRBG8,
> > +		.code			=3D MEDIA_BUS_FMT_SGRBG8_1X8,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW8,
> > +		.bpp			=3D 8,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SRGGB8,
> > +		.code			=3D MEDIA_BUS_FMT_SRGGB8_1X8,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW8,
> > +		.bpp			=3D 8,
> > +		.size			=3D SHIM_DMACNTX_SIZE_8,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SBGGR10,
> > +		.code			=3D MEDIA_BUS_FMT_SBGGR10_1X10,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW10,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_16,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SGBRG10,
> > +		.code			=3D MEDIA_BUS_FMT_SGBRG10_1X10,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW10,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_16,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SGRBG10,
> > +		.code			=3D MEDIA_BUS_FMT_SGRBG10_1X10,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW10,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_16,
> > +	}, {
> > +		.fourcc			=3D V4L2_PIX_FMT_SRGGB10,
> > +		.code			=3D MEDIA_BUS_FMT_SRGGB10_1X10,
> > +		.csi_dt			=3D MIPI_CSI2_DT_RAW10,
> > +		.bpp			=3D 16,
> > +		.size			=3D SHIM_DMACNTX_SIZE_16,
> > +	},
> > +
> > +	/* More formats can be supported but they are not listed for now. */
> > +};
> > +
> > +static const unsigned int num_formats =3D ARRAY_SIZE(formats);
>=20
> I would use ARRAY_SIZE(formats) below and drop num_formats, as I don't
> think it improves readability, but I don't insist.
>=20

Will fix.

> > +
> > +/* Forward declaration needed by ti_csi2rx_dma_callback. */
> > +static int ti_csi2rx_start_dma(struct ti_csi2rx_dev *csi,
> > +			       struct ti_csi2rx_buffer *buf);
> > +
> > +static const struct ti_csi2rx_fmt *find_format_by_pix(u32 pixelformat)
>=20
> Maybe "_by_fourcc" ? That's nitpicking though.
>=20

Will fix.

> > +{
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < num_formats; i++) {
> > +		if (formats[i].fourcc =3D=3D pixelformat)
> > +			return &formats[i];
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static const struct ti_csi2rx_fmt *find_format_by_code(u32 code)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < num_formats; i++) {
> > +		if (formats[i].code =3D=3D code)
> > +			return &formats[i];
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static void ti_csi2rx_fill_fmt(const struct ti_csi2rx_fmt *csi_fmt,
> > +			       struct v4l2_format *v4l2_fmt)
> > +{
> > +	struct v4l2_pix_format *pix =3D &v4l2_fmt->fmt.pix;
> > +	unsigned int pixels_in_word;
> > +	u8 bpp =3D ALIGN(csi_fmt->bpp, 8);
>=20
> All bpp values are multiple of 8, is ALIGN() needed ?
>=20

Hmm you're right it's not really needed, I think I decided to keep it=20
=66rom Pratyush's series just to be safe. Will remove it in v10.

> > +
> > +	pixels_in_word =3D PSIL_WORD_SIZE_BYTES * 8 / bpp;
> > +
> > +	/* Clamp width and height to sensible maximums (16K x 16K) */
> > +	pix->width =3D clamp_t(unsigned int, pix->width,
> > +			     pixels_in_word,
> > +			     MAX_WIDTH_BYTES * 8 / bpp);
> > +	pix->height =3D clamp_t(unsigned int, pix->height, 1, MAX_HEIGHT_LINE=
S);
> > +
> > +	/* Width should be a multiple of transfer word-size */
> > +	pix->width =3D rounddown(pix->width, pixels_in_word);
> > +
> > +	v4l2_fmt->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
> > +	pix->pixelformat =3D csi_fmt->fourcc;
> > +	pix->colorspace =3D V4L2_COLORSPACE_SRGB;
>=20
> You should fill the other colorspace-related fields.
>=20

Good catch, I think it would be better to use the colorspace and related=20
fields from the mbus format of the source subdev as this IP doesn't=20
really change it. Will fix in v10.

> > +	pix->bytesperline =3D pix->width * (bpp / 8);
> > +	pix->sizeimage =3D pix->bytesperline * pix->height;
> > +}
> > +
> > +static int ti_csi2rx_querycap(struct file *file, void *priv,
> > +			      struct v4l2_capability *cap)
> > +{
> > +	strscpy(cap->driver, TI_CSI2RX_MODULE_NAME, sizeof(cap->driver));
> > +	strscpy(cap->card, TI_CSI2RX_MODULE_NAME, sizeof(cap->card));
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_enum_fmt_vid_cap(struct file *file, void *priv,
> > +				      struct v4l2_fmtdesc *f)
> > +{
> > +	const struct ti_csi2rx_fmt *fmt =3D NULL;
> > +
> > +	if (f->mbus_code) {
> > +		/* 1-to-1 mapping between bus formats and pixel formats */
> > +		if (f->index > 0)
> > +			return -EINVAL;
> > +
> > +		fmt =3D find_format_by_code(f->mbus_code);
> > +	} else {
> > +		if (f->index >=3D num_formats)
> > +			return -EINVAL;
> > +
> > +		fmt =3D &formats[f->index];
> > +	}
> > +
> > +	if (!fmt)
> > +		return -EINVAL;
> > +
> > +	f->pixelformat =3D fmt->fourcc;
> > +	memset(f->reserved, 0, sizeof(f->reserved));
> > +	f->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_g_fmt_vid_cap(struct file *file, void *prov,
> > +				   struct v4l2_format *f)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D video_drvdata(file);
> > +
> > +	*f =3D csi->v_fmt;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_try_fmt_vid_cap(struct file *file, void *priv,
> > +				     struct v4l2_format *f)
> > +{
> > +	const struct ti_csi2rx_fmt *fmt;
> > +
> > +	/*
> > +	 * Default to the first format if the requested pixel format code isn=
't
> > +	 * supported.
> > +	 */
> > +	fmt =3D find_format_by_pix(f->fmt.pix.pixelformat);
> > +	if (!fmt)
> > +		fmt =3D &formats[0];
> > +
> > +	/* Interlaced formats are not supported. */
> > +	f->fmt.pix.field =3D V4L2_FIELD_NONE;
> > +
> > +	ti_csi2rx_fill_fmt(fmt, f);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_s_fmt_vid_cap(struct file *file, void *priv,
> > +				   struct v4l2_format *f)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D video_drvdata(file);
> > +	struct vb2_queue *q =3D &csi->vidq;
> > +	int ret;
> > +
> > +	if (vb2_is_busy(q))
> > +		return -EBUSY;
> > +
> > +	ret =3D ti_csi2rx_try_fmt_vid_cap(file, priv, f);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	csi->v_fmt =3D *f;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_enum_framesizes(struct file *file, void *fh,
> > +				     struct v4l2_frmsizeenum *fsize)
> > +{
> > +	const struct ti_csi2rx_fmt *fmt;
> > +	unsigned int pixels_in_word;
> > +	u8 bpp;
> > +
> > +	fmt =3D find_format_by_pix(fsize->pixel_format);
> > +	if (!fmt || fsize->index !=3D 0)
> > +		return -EINVAL;
> > +
> > +	bpp =3D ALIGN(fmt->bpp, 8);
> > +
> > +	/*
> > +	 * Number of pixels in one PSI-L word. The transfer happens in multip=
les
> > +	 * of PSI-L word sizes.
> > +	 */
> > +	pixels_in_word =3D PSIL_WORD_SIZE_BYTES * 8 / bpp;
> > +
> > +	fsize->type =3D V4L2_FRMSIZE_TYPE_STEPWISE;
> > +	fsize->stepwise.min_width =3D pixels_in_word;
> > +	fsize->stepwise.max_width =3D rounddown(MAX_WIDTH_BYTES * 8 / bpp,
> > +					      pixels_in_word);
> > +	fsize->stepwise.step_width =3D pixels_in_word;
> > +	fsize->stepwise.min_height =3D 1;
> > +	fsize->stepwise.max_height =3D MAX_HEIGHT_LINES;
> > +	fsize->stepwise.step_height =3D 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct v4l2_ioctl_ops csi_ioctl_ops =3D {
> > +	.vidioc_querycap      =3D ti_csi2rx_querycap,
> > +	.vidioc_enum_fmt_vid_cap =3D ti_csi2rx_enum_fmt_vid_cap,
> > +	.vidioc_try_fmt_vid_cap =3D ti_csi2rx_try_fmt_vid_cap,
> > +	.vidioc_g_fmt_vid_cap =3D ti_csi2rx_g_fmt_vid_cap,
> > +	.vidioc_s_fmt_vid_cap =3D ti_csi2rx_s_fmt_vid_cap,
> > +	.vidioc_enum_framesizes =3D ti_csi2rx_enum_framesizes,
> > +	.vidioc_reqbufs       =3D vb2_ioctl_reqbufs,
> > +	.vidioc_create_bufs   =3D vb2_ioctl_create_bufs,
> > +	.vidioc_prepare_buf   =3D vb2_ioctl_prepare_buf,
> > +	.vidioc_querybuf      =3D vb2_ioctl_querybuf,
> > +	.vidioc_qbuf          =3D vb2_ioctl_qbuf,
> > +	.vidioc_dqbuf         =3D vb2_ioctl_dqbuf,
> > +	.vidioc_expbuf        =3D vb2_ioctl_expbuf,
> > +	.vidioc_streamon      =3D vb2_ioctl_streamon,
> > +	.vidioc_streamoff     =3D vb2_ioctl_streamoff,
> > +};
> > +
> > +static const struct v4l2_file_operations csi_fops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.open =3D v4l2_fh_open,
> > +	.release =3D vb2_fop_release,
> > +	.read =3D vb2_fop_read,
> > +	.poll =3D vb2_fop_poll,
> > +	.unlocked_ioctl =3D video_ioctl2,
> > +	.mmap =3D vb2_fop_mmap,
> > +};
> > +
> > +static int csi_async_notifier_bound(struct v4l2_async_notifier *notifi=
er,
> > +				    struct v4l2_subdev *subdev,
> > +				    struct v4l2_async_connection *asc)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D dev_get_drvdata(notifier->v4l2_dev->dev=
);
> > +
> > +	csi->source =3D subdev;
> > +
> > +	return 0;
> > +}
> > +
> > +static int csi_async_notifier_complete(struct v4l2_async_notifier *not=
ifier)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D dev_get_drvdata(notifier->v4l2_dev->dev=
);
> > +	struct video_device *vdev =3D &csi->vdev;
> > +	int ret;
> > +
> > +	ret =3D video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D v4l2_create_fwnode_links_to_pad(csi->source, &csi->pad,
> > +					      MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> > +
> > +	if (ret) {
> > +		video_unregister_device(vdev);
> > +		return ret;
> > +	}
> > +
> > +	return v4l2_device_register_subdev_nodes(&csi->v4l2_dev);
>=20
> You should call video_unregister_device() if this fails.

Will fix.

>=20
> I'm tempted, however, to register the video device at probe time, not in
> this function.
>

My guess is this was done here to prevent creating a video node if=20
sensor (source subdev) failed to probe. With multistream support we will=20
have multiple video nodes (upto 16) where it seems cleaner to wait for=20
the source. Let me know if you had some other reason in mind.

> > +}
> > +
> > +static const struct v4l2_async_notifier_operations csi_async_notifier_=
ops =3D {
> > +	.bound =3D csi_async_notifier_bound,
> > +	.complete =3D csi_async_notifier_complete,
> > +};
> > +
> > +static int ti_csi2rx_notifier_register(struct ti_csi2rx_dev *csi)
> > +{
> > +	struct fwnode_handle *fwnode;
> > +	struct v4l2_async_connection *asc;
> > +	struct device_node *node;
> > +	int ret;
> > +
> > +	node =3D of_get_child_by_name(csi->dev->of_node, "csi-bridge");
> > +	if (!node)
> > +		return -EINVAL;
> > +
> > +	fwnode =3D of_fwnode_handle(node);
> > +	if (!fwnode) {
> > +		of_node_put(node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	v4l2_async_nf_init(&csi->notifier, &csi->v4l2_dev);
> > +	csi->notifier.ops =3D &csi_async_notifier_ops;
> > +
> > +	asc =3D v4l2_async_nf_add_fwnode(&csi->notifier, fwnode,
> > +				       struct v4l2_async_connection);
> > +	of_node_put(node);
> > +	if (IS_ERR(asc)) {
> > +		v4l2_async_nf_cleanup(&csi->notifier);
> > +		return PTR_ERR(asc);
> > +	}
> > +
> > +	ret =3D v4l2_async_nf_register(&csi->notifier);
> > +	if (ret) {
> > +		v4l2_async_nf_cleanup(&csi->notifier);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_setup_shim(struct ti_csi2rx_dev *csi)
> > +{
> > +	const struct ti_csi2rx_fmt *fmt;
> > +	unsigned int reg;
> > +
> > +	fmt =3D find_format_by_pix(csi->v_fmt.fmt.pix.pixelformat);
> > +	if (!fmt) {
> > +		dev_err(csi->dev, "Pixelformat 0x%x is not supported\n",
>=20
> Use %p4cc to print a fourcc. You need to pass the pixel format by
> address to dev_err() then, not by value.
>=20
> Can this happen though, given that the set format handler should never
> allow setting a format not supported by the driver ? I think I'd drop
> the error check. The function can then become a void function.
>=20

Makes sense, will drop this.

> > +			csi->v_fmt.fmt.pix.pixelformat);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* De-assert the pixel interface reset. */
> > +	reg =3D SHIM_CNTL_PIX_RST;
> > +	writel(reg, csi->shim + SHIM_CNTL);
> > +
> > +	reg =3D SHIM_DMACNTX_EN;
> > +	reg |=3D FIELD_PREP(SHIM_DMACNTX_FMT, fmt->csi_dt);
> > +
> > +	/*
> > +	 * Using the values from the documentation gives incorrect ordering f=
or
> > +	 * the luma and chroma components. In practice, the "reverse" format
> > +	 * gives the correct image. So for example, if the image is in UYVY, =
the
> > +	 * reverse would be YVYU.
> > +	 */
> > +	switch (fmt->fourcc) {
> > +	case V4L2_PIX_FMT_UYVY:
> > +		reg |=3D FIELD_PREP(SHIM_DMACNTX_YUV422,
> > +					SHIM_DMACNTX_YVYU);
> > +		break;
> > +	case V4L2_PIX_FMT_VYUY:
> > +		reg |=3D FIELD_PREP(SHIM_DMACNTX_YUV422,
> > +					SHIM_DMACNTX_YUYV);
> > +		break;
> > +	case V4L2_PIX_FMT_YUYV:
> > +		reg |=3D FIELD_PREP(SHIM_DMACNTX_YUV422,
> > +					SHIM_DMACNTX_VYUY);
> > +		break;
> > +	case V4L2_PIX_FMT_YVYU:
> > +		reg |=3D FIELD_PREP(SHIM_DMACNTX_YUV422,
> > +					SHIM_DMACNTX_UYVY);
> > +		break;
> > +	default:
> > +		/* Ignore if not YUV 4:2:2 */
> > +		break;
> > +	}
> > +
> > +	reg |=3D FIELD_PREP(SHIM_DMACNTX_SIZE, fmt->size);
> > +
> > +	writel(reg, csi->shim + SHIM_DMACNTX);
> > +
> > +	reg =3D FIELD_PREP(SHIM_PSI_CFG0_SRC_TAG, 0) |
> > +	      FIELD_PREP(SHIM_PSI_CFG0_DST_TAG, 0);
> > +	writel(reg, csi->shim + SHIM_PSI_CFG0);
> > +
> > +	return 0;
> > +}
> > +
> > +static void ti_csi2rx_drain_callback(void *param)
> > +{
> > +	struct completion *drain_complete =3D param;
> > +
> > +	complete(drain_complete);
> > +}
> > +
> > +/** Drain the stale data left at the PSI-L endpoint.
>=20
> This isn't kerneldoc, so
>=20
> /*
>  * Drain the stale data left at the PSI-L endpoint.
>=20

Will fix.

> > + *
> > + * This might happen if no buffers are queued in time but source is st=
ill
> > + * streaming. Or rarely it may happen while stopping the stream. To pr=
event
> > + * that stale data corrupting the subsequent transactions, it is requi=
red to
> > + * issue DMA requests to drain it out.
> > + */
> > +static int ti_csi2rx_drain_dma(struct ti_csi2rx_dev *csi)
> > +{
> > +	struct dma_async_tx_descriptor *desc;
> > +	struct completion drain_complete;
> > +	dma_cookie_t cookie;
> > +	int ret;
> > +
> > +	init_completion(&drain_complete);
> > +
> > +	desc =3D dmaengine_prep_slave_single(csi->dma.chan, csi->dma.drain.pa=
ddr,
> > +					   csi->dma.drain.len, DMA_DEV_TO_MEM,
> > +					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> > +	if (!desc) {
> > +		ret =3D -EIO;
> > +		goto out;
> > +	}
> > +
> > +	desc->callback =3D ti_csi2rx_drain_callback;
> > +	desc->callback_param =3D &drain_complete;
> > +
> > +	cookie =3D dmaengine_submit(desc);
> > +	ret =3D dma_submit_error(cookie);
> > +	if (ret)
> > +		goto out;
> > +
> > +	dma_async_issue_pending(csi->dma.chan);
> > +
> > +	if (!wait_for_completion_timeout(&drain_complete,
> > +					 msecs_to_jiffies(DRAIN_TIMEOUT_MS))) {
> > +		dmaengine_terminate_sync(csi->dma.chan);
> > +		ret =3D -ETIMEDOUT;
> > +		goto out;
> > +	}
> > +out:
> > +	return ret;
> > +}
> > +
> > +static void ti_csi2rx_dma_callback(void *param)
> > +{
> > +	struct ti_csi2rx_buffer *buf =3D param;
> > +	struct ti_csi2rx_dev *csi =3D buf->csi;
> > +	struct ti_csi2rx_dma *dma =3D &csi->dma;
> > +	unsigned long flags;
> > +
> > +	/*
> > +	 * TODO: Derive the sequence number from the CSI2RX frame number
> > +	 * hardware monitor registers.
> > +	 */
> > +	buf->vb.vb2_buf.timestamp =3D ktime_get_ns();
> > +	buf->vb.sequence =3D csi->sequence++;
> > +
> > +	spin_lock_irqsave(&dma->lock, flags);
> > +
> > +	WARN_ON(!list_is_first(&buf->list, &dma->submitted));
> > +	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
> > +	list_del(&buf->list);
> > +
> > +	/* If there are more buffers to process then start their transfer. */
> > +	while (!list_empty(&dma->queue)) {
> > +		buf =3D list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
> > +
> > +		if (ti_csi2rx_start_dma(csi, buf)) {
> > +			dev_err(csi->dev, "Failed to queue the next buffer for DMA\n");
> > +			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> > +		} else {
> > +			list_move_tail(&buf->list, &dma->submitted);
> > +		}
> > +	}
> > +
> > +	if (list_empty(&dma->submitted))
> > +		dma->state =3D TI_CSI2RX_DMA_IDLE;
> > +
> > +	spin_unlock_irqrestore(&dma->lock, flags);
> > +}
> > +
> > +static int ti_csi2rx_start_dma(struct ti_csi2rx_dev *csi,
> > +			       struct ti_csi2rx_buffer *buf)
> > +{
> > +	unsigned long addr;
> > +	struct dma_async_tx_descriptor *desc;
> > +	size_t len =3D csi->v_fmt.fmt.pix.sizeimage;
> > +	dma_cookie_t cookie;
> > +	int ret =3D 0;
> > +
> > +	addr =3D vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
> > +	desc =3D dmaengine_prep_slave_single(csi->dma.chan, addr, len,
> > +					   DMA_DEV_TO_MEM,
> > +					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> > +	if (!desc)
> > +		return -EIO;
> > +
> > +	desc->callback =3D ti_csi2rx_dma_callback;
> > +	desc->callback_param =3D buf;
> > +
> > +	cookie =3D dmaengine_submit(desc);
> > +	ret =3D dma_submit_error(cookie);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dma_async_issue_pending(csi->dma.chan);
> > +
> > +	return 0;
> > +}
> > +
> > +static void ti_csi2rx_cleanup_buffers(struct ti_csi2rx_dev *csi,
> > +				      enum vb2_buffer_state buf_state)
> > +{
> > +	struct ti_csi2rx_dma *dma =3D &csi->dma;
> > +	struct ti_csi2rx_buffer *buf, *tmp;
> > +	enum ti_csi2rx_dma_state state;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&dma->lock, flags);
> > +	state =3D csi->dma.state;
> > +	dma->state =3D TI_CSI2RX_DMA_STOPPED;
> > +	spin_unlock_irqrestore(&dma->lock, flags);
> > +
> > +	if (state !=3D TI_CSI2RX_DMA_STOPPED) {
> > +		/*
> > +		 * Normal DMA termination sometimes does not clean up pending
> > +		 * data on the endpoint.
> > +		 */
> > +		ret =3D ti_csi2rx_drain_dma(csi);
> > +		if (ret)
> > +			dev_dbg(csi->dev,
> > +				"Failed to drain DMA. Next frame might be bogus\n");
>=20
> A dev_warn() may be more appropriate, this seems quite important.
>=20

I think this was intentional. The calls to DMA engine for draining=20
always "timeout" even when the drain is successful, because the amount=20
of data drained is non-deterministic (and we use framesize to be safe,=20
which is much more than what FIFOs would be storing). Keeping this as=20
dev_warn() leads to spurious dmesg logs at the end of every stream=20
close.

Maybe we should use dev_dbg for the timeout case, and dev_err for any=20
other error thrown by DMA engine. Will fix that in v10.

Hopefully this will be simplified once we have an API in place to signal=20
drain to "/dev/null".

> > +	}
>=20
> A blank line would be nice here.
>=20

Will fix.

> > +	ret =3D dmaengine_terminate_sync(csi->dma.chan);
> > +	if (ret)
> > +		dev_err(csi->dev, "Failed to stop DMA: %d\n", ret);
>=20
> When called from ti_csi2rx_start_streaming() there's already a
> dmaengine_terminate_sync(), and there's also a call to the same function
> in ti_csi2rx_drain_dma() called above. Could we avoid calling the
> function multiple times ? I think stopping the DMA engine should be
> moved to a separate function, as it doesn't fit with the
> ti_csi2rx_cleanup_buffers() name.
>=20

Oops missed that, will fix.

> > +
> > +	dma_free_coherent(csi->dev, dma->drain.len,
> > +			  dma->drain.vaddr, dma->drain.paddr);
> > +	dma->drain.vaddr =3D NULL;
> > +
> > +	spin_lock_irqsave(&dma->lock, flags);
> > +	list_for_each_entry_safe(buf, tmp, &csi->dma.queue, list) {
> > +		list_del(&buf->list);
> > +		vb2_buffer_done(&buf->vb.vb2_buf, buf_state);
> > +	}
> > +	list_for_each_entry_safe(buf, tmp, &csi->dma.submitted, list) {
> > +		list_del(&buf->list);
> > +		vb2_buffer_done(&buf->vb.vb2_buf, buf_state);
> > +	}
> > +	spin_unlock_irqrestore(&dma->lock, flags);
> > +}
> > +
> > +static int ti_csi2rx_queue_setup(struct vb2_queue *q, unsigned int *nb=
uffers,
> > +				 unsigned int *nplanes, unsigned int sizes[],
> > +				 struct device *alloc_devs[])
> > +{
> > +	struct ti_csi2rx_dev *csi =3D vb2_get_drv_priv(q);
> > +	unsigned int size =3D csi->v_fmt.fmt.pix.sizeimage;
> > +
> > +	if (*nplanes) {
> > +		if (sizes[0] < size)
> > +			return -EINVAL;
> > +		size =3D sizes[0];
> > +	}
> > +
> > +	*nplanes =3D 1;
> > +	sizes[0] =3D size;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_csi2rx_buffer_prepare(struct vb2_buffer *vb)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D vb2_get_drv_priv(vb->vb2_queue);
> > +	unsigned long size =3D csi->v_fmt.fmt.pix.sizeimage;
> > +
> > +	if (vb2_plane_size(vb, 0) < size) {
> > +		dev_err(csi->dev, "Data will not fit into plane\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	vb2_set_plane_payload(vb, 0, size);
> > +	return 0;
> > +}
> > +
> > +static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
> > +{
> > +	struct ti_csi2rx_dev *csi =3D vb2_get_drv_priv(vb->vb2_queue);
> > +	struct ti_csi2rx_buffer *buf;
> > +	struct ti_csi2rx_dma *dma =3D &csi->dma;
> > +	bool restart_dma =3D false;
> > +	unsigned long flags =3D 0;
> > +	int ret;
> > +
> > +	buf =3D container_of(vb, struct ti_csi2rx_buffer, vb.vb2_buf);
> > +	buf->csi =3D csi;
> > +
> > +	spin_lock_irqsave(&dma->lock, flags);
> > +	/*
> > +	 * Usually the DMA callback takes care of queueing the pending buffer=
s.
> > +	 * But if DMA has stalled due to lack of buffers, restart it now.
> > +	 */
> > +	if (dma->state =3D=3D TI_CSI2RX_DMA_IDLE) {
> > +		/*
> > +		 * Do not restart DMA with the lock held because
> > +		 * ti_csi2rx_drain_dma() might block for completion.
> > +		 * There won't be a race on queueing DMA anyway since the
> > +		 * callback is not being fired.
> > +		 */
> > +		restart_dma =3D true;
> > +		dma->state =3D TI_CSI2RX_DMA_ACTIVE;
> > +	} else {
> > +		list_add_tail(&buf->list, &dma->queue);
> > +	}
> > +	spin_unlock_irqrestore(&dma->lock, flags);
> > +
> > +	if (restart_dma) {
> > +		/*
> > +		 * Once frames start dropping, some data gets stuck in the DMA
> > +		 * pipeline somewhere. So the first DMA transfer after frame
> > +		 * drops gives a partial frame. This is obviously not useful to
> > +		 * the application and will only confuse it. Issue a DMA
> > +		 * transaction to drain that up.
> > +		 */
>=20
> Another option would be to return the frame to userspace with the error
> flag set. That would give an earlier indication to applications that
> something went wrong. Up to you.
>=20

Oh I see, that does sound cleaner to me - I will try that out with=20
different applications. If it works, would it be okay if I handle it as=20
a separate series? The mechanism in this series is already well-tested,=20
even if a bit ugly.

> > +		ret =3D ti_csi2rx_drain_dma(csi);
> > +		if (ret)
> > +			dev_warn(csi->dev,
> > +				 "Failed to drain DMA. Next frame might be bogus\n");
> > +
> > +		ret =3D ti_csi2rx_start_dma(csi, buf);
> > +		if (ret) {
> > +			dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
> > +			spin_lock_irqsave(&dma->lock, flags);
> > +			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> > +			dma->state =3D TI_CSI2RX_DMA_IDLE;
> > +			spin_unlock_irqrestore(&dma->lock, flags);
> > +		} else {
> > +			spin_lock_irqsave(&dma->lock, flags);
> > +			list_add_tail(&buf->list, &dma->submitted);
> > +			spin_unlock_irqrestore(&dma->lock, flags);
> > +		}
> > +	}

[snip]

>=20
> -- Regards,
>=20
> Laurent Pinchart

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--7jjrsghq242jhmur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmUedRMACgkQQ96R+SSa
cUWS8xAAtDxqWSsr5kBw15Mv2cAQrtj2kqw0KQVnSljLzJvmNv/BI4oGNSP1PMTV
G1sSNot4H3tE76e24hAYwXchoQA75jDRHKQ+J9v0fl9SZznXGBu9f2s8nUzO2TOv
6VPbdTIy6xeQUa3PFp4TpFdYLZBZ6ZX9vNOe7XXfQs0tpA3/mwwmIA/8FpyQ/7IK
nxuvOXOv/cEZU0vW4ySvUq6/DIHjEBlndj04CM56htrMRa4VzEK2XjtuB+a3CXSx
zsqHjOMj2mmMW+6kOhuk05wpwAoC1zGLBfKBsCbuc0vyaiKM78pUkKw9Uhoc4uEL
RFrepqljiWF/0Xxj2TH+vILbrylryHVFgEaZxqTmDtPNznYLHvFgYe5t3TW6CpsS
C49QkRtQagiurx3ZTU1U5NkxC4k6mNw3+3jdal/xRPKAWcO0dw9TD0gRqMwVZPZL
+FICl1vznaXdkvhYBX7qfpkG6fEmbh1iNZThRMsVcjlhYYNm+ekIXu8iftQv+uu9
LcdUk3gI6quJiTH+R3nVAFmkOHIpOJnyZW1Dbz87LvT5ZatOF0gFFSzjq9PL4DRS
ynPoqkZePG92t1rxCWau9iQxxiyzL2JXZt/xiLzyXsY049Py1KIa2i75W1CrAtJj
1pPdgROKoFISYJCqufuyTyjjxlaM2wYFbclI8kZq2om5H3tghi0=
=Svlt
-----END PGP SIGNATURE-----

--7jjrsghq242jhmur--
