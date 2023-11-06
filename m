Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165407E1D64
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjKFJnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjKFJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:43:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CACE1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:43:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1CDC433C8;
        Mon,  6 Nov 2023 09:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699263820;
        bh=mW57g3/oo1AgcyVKDztTrcwktcxhtqaiT1BLrsHk/WM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tn/boXB5eKY5pI6iM/T1MWnfyTzOajgPL6jvcIBqLVRYycUwM0Jci7ErTJRpBiHBs
         Ba85sQTjKSR97qqj/Q9eNy8Ougm3Jz+L9kh0HhJX6KSxKt1Dbe2L0br/zEogSPZmFf
         1lpVerA/r+Ox/SlOXsRqEU/Lx44E/++VN/pGSutCXMQ5gmjxUFImPkMM+6zjOL396N
         ksYT0tZJmqh/aFQyXfmTLxrk3oCd78BkuYmfafk/kfVbjB9gzHzpqmqodmI9CYdL57
         K4cagrLD6Gyfcs9KYUHZTyFCrV8sLAezXFJmxlfL1+28+zz4R9Kwh1olam7LY4DcPr
         2WjKY59BBrtyQ==
Date:   Mon, 6 Nov 2023 10:43:37 +0100
From:   "mripard@kernel.org" <mripard@kernel.org>
To:     Frank Binns <Frank.Binns@imgtec.com>
Cc:     "faith.ekstrand@collabora.com" <faith.ekstrand@collabora.com>,
        Sarah Walker <Sarah.Walker@imgtec.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "luben.tuikov@amd.com" <luben.tuikov@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "dakr@redhat.com" <dakr@redhat.com>,
        "hns@goldelico.com" <hns@goldelico.com>, "afd@ti.com" <afd@ti.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "matthew.brost@intel.com" <matthew.brost@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH v8 00/20] Imagination Technologies PowerVR DRM driver
Message-ID: <a2eo2cloaiswrujkn6qffswobi2foc5ifuc676jx2k2jyuahgu@meuurfcb4uel>
References: <20231031151257.90350-1-sarah.walker@imgtec.com>
 <lg7cdw3qlak74zefbx25f5pnazrburteldueoqz7o7cphydqp7@q56er3qa5muf>
 <eb0dcfe7a5f4da207bdbbd9630e5d6e5c940dfa5.camel@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r3wyv22s6z5b2f2v"
Content-Disposition: inline
In-Reply-To: <eb0dcfe7a5f4da207bdbbd9630e5d6e5c940dfa5.camel@imgtec.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r3wyv22s6z5b2f2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Frank,

On Wed, Nov 01, 2023 at 10:15:15AM +0000, Frank Binns wrote:
> Hi Maxime,
>=20
> On Tue, 2023-10-31 at 17:31 +0100, Maxime Ripard wrote:
> > Hi Sarah, Faith, Frank,
> >=20
> > On Tue, Oct 31, 2023 at 03:12:37PM +0000, Sarah Walker wrote:
> > > This patch series adds the initial DRM driver for Imagination Technol=
ogies PowerVR
> > > GPUs, starting with those based on our Rogue architecture. It's worth=
 pointing
> > > out that this is a new driver, written from the ground up, rather tha=
n a
> > > refactored version of our existing downstream driver (pvrsrvkm).
> > >=20
> > > This new DRM driver supports:
> > > - GEM shmem allocations
> > > - dma-buf / PRIME
> > > - Per-context userspace managed virtual address space
> > > - DRM sync objects (binary and timeline)
> > > - Power management suspend / resume
> > > - GPU job submission (geometry, fragment, compute, transfer)
> > > - META firmware processor
> > > - MIPS firmware processor
> > > - GPU hang detection and recovery
> > >=20
> > > Currently our main focus is on the AXE-1-16M GPU. Testing so far has =
been done
> > > using a TI SK-AM62 board (AXE-1-16M GPU). The driver has also been co=
nfirmed to
> > > work on the BeaglePlay board. Firmware for the AXE-1-16M can befound =
here:
> > > https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/tree/power=
vr
> > >=20
> > > A Vulkan driver that works with our downstream kernel driver has alre=
ady been
> > > merged into Mesa [1][2]. Support for this new DRM driver is being mai=
ntained in
> > > a merge request [3], with the branch located here:
> > > https://gitlab.freedesktop.org/frankbinns/mesa/-/tree/powervr-winsys
> > >=20
> > > Job stream formats are documented at:
> > > https://gitlab.freedesktop.org/mesa/mesa/-/blob/f8d2b42ae65c2f16f36a4=
3e0ae39d288431e4263/src/imagination/csbgen/rogue_kmd_stream.xml
> > >=20
> > > The Vulkan driver is progressing towards Vulkan 1.0. The current comb=
ination of this
> > > kernel driver with the Mesa Vulkan driver (powervr-mesa-next branch) =
successfully
> > > completes Vulkan CTS 1.3.4.1 in our local runs. The driver is expecte=
d to pass the
> > > Khronos Conformance Process once the submission is made.
> > >=20
> > > The code in this patch series, along with the needed dts changes can =
be found here:
> > > https://gitlab.freedesktop.org/sarah-walker-imgtec/powervr/-/tree/dev=
/v8_dts
> > > The full development history can be found here:
> > > https://gitlab.freedesktop.org/frankbinns/powervr/-/tree/powervr-next
> >=20
> > Awesome, thanks for sending a new version of that series.
> >=20
> > At XDC, we all agreed that we would merge this version if the changes
> > requested by Faith were fixed, and if the Mesa PR was updated to match
> > that new kernel series.
> >=20
> > Are we there yet?
>=20
> We've made all the changes that were requested at XDC. There are a couple=
 of
> questions Faith had for me that I still need to respond to. I'll hopefull=
y be
> getting to these today.
>=20
> The Mesa MR adding support for this kernel driver is all up to date:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/15507

Ok, great :)

> > If so, Faith, should we add your Reviewed-by/Acked-by tag to the UAPI p=
atch?
> >=20
> > > This patch series has dependencies on a number of patches not yet mer=
ged. They
> > > are listed below :
> > >=20
> > > drm/sched: Convert drm scheduler to use a work queue rather than kthr=
ead:
> > >   https://lore.kernel.org/dri-devel/20230404002211.3611376-2-matthew.=
brost@intel.com/
> > > drm/sched: Move schedule policy to scheduler / entity:
> > >   https://lore.kernel.org/dri-devel/20230404002211.3611376-3-matthew.=
brost@intel.com/
> > > drm/sched: Add DRM_SCHED_POLICY_SINGLE_ENTITY scheduling policy:
> > >   https://lore.kernel.org/dri-devel/20230404002211.3611376-4-matthew.=
brost@intel.com/
> > > drm/sched: Start run wq before TDR in drm_sched_start:
> > >   https://lore.kernel.org/dri-devel/20230404002211.3611376-6-matthew.=
brost@intel.com/
> > > drm/sched: Submit job before starting TDR:
> > >   https://lore.kernel.org/dri-devel/20230404002211.3611376-7-matthew.=
brost@intel.com/
> > > drm/sched: Add helper to set TDR timeout:
> > >   https://lore.kernel.org/dri-devel/20230404002211.3611376-8-matthew.=
brost@intel.com/
> >=20
> > What is the state of those patches? Iirc, we were expecting them to be
> > merged soon at XDC
>=20
> I see there was a new version posted yesterday:
> https://lists.freedesktop.org/archives/dri-devel/2023-October/428612.html
>=20
> It looks pretty close now. We'll rebase our patches so hopefully we have a
> trivial rebase once they get merged.

It looks like it's been merged last Wednesday, so I guess we can move
forward on this?

Maxime

--r3wyv22s6z5b2f2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZUi1SQAKCRDj7w1vZxhR
xdUsAP4i+05ShczLQ2FI8+SrV8Li2WkzO07REWaHFGt3x7dGewEA7dZ9GE1aIscC
uvLu+cPb1BHF93SCBChUim7WcipZJgE=
=OnRV
-----END PGP SIGNATURE-----

--r3wyv22s6z5b2f2v--
