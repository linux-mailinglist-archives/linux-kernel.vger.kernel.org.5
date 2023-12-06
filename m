Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E47580699B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376928AbjLFI2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377123AbjLFI2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:28:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117391B6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:28:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180D6C433C7;
        Wed,  6 Dec 2023 08:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701851296;
        bh=sU8+eqKAhaWBMNLJPx1p/1ISVUYieuL8KIL5od5DX0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmccKKebKM5mwg2/B4Y8Wt19A+wDmKYBEndZHThNUSPRD+aizPTHPiFYaHOkanIhf
         6fk/KzaSMhoU9X8wZiuhhDulopW0qaHa1Be3bG6dj5fyJZvLe81aMUpsmT5LnQiYBw
         tWnTp410gLyXPIUrCmGm/yDtYb0e/hrxR22kpfJOE8zPwFEtx4LvePguhXEFoiHXMB
         bGAbIQ6MhIZ4IGqsJlv8bACi1n8FHFdqR+jT54lvam4d29JLOvEdRggO9I3/VNWQ6/
         nDADTavqce6b9fuu5xQP3jogTtXTOco1+WcxkhNIz21cqI5JPCRInE/T+iAbvxe9lI
         uMEgHoZwNrsiQ==
Date:   Wed, 6 Dec 2023 09:28:13 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     sarah.walker@imgtec.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, matt.coster@imgtec.com,
        donald.robson@imgtec.com
Subject: Re: [PATCH drm-misc-next v2 0/2] PowerVR VM fixes
Message-ID: <z247vadh756u7hxwiwzhpo2xya4cvdol52x3uosgn4skqlfd4x@qhysktnkid4w>
References: <20231129220835.297885-1-dakr@redhat.com>
 <j6w6ccewlvoosop77ug56r3sqoi4hglj3ejkyfw4dj3s3pdsw5@b473njzq5u3d>
 <ZW9EeFWWZ0BMWIPq@pollux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sl2scc7rzqim4vqm"
Content-Disposition: inline
In-Reply-To: <ZW9EeFWWZ0BMWIPq@pollux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sl2scc7rzqim4vqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 04:40:40PM +0100, Danilo Krummrich wrote:
> On Tue, Dec 05, 2023 at 04:35:00PM +0100, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Wed, Nov 29, 2023 at 11:07:59PM +0100, Danilo Krummrich wrote:
> > > Some major GPUVM changes landed just before v8 of the PowerVR series.=
 Since v8
> > > went in rather quickly (review process was finished otherwise) I have=
n't had the
> > > chance to review the subsequent code changes.
> > >=20
> > > Hence, this series with a few fixes in this context. Plus a minor GPU=
VM patch to
> > > make the drm_gpuvm_prepare_* helpers useful for PowerVR.
> >=20
> > This doesn't apply on drm-misc-next anymore, could you rebase and
> > resend?
>=20
> I already applied the two patches to drm-misc-next.

Uh, sorry I didn't notice it.

Maxime

--sl2scc7rzqim4vqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXAwnQAKCRDj7w1vZxhR
xekkAQCzruxmg1F6tADUsr1XprRFoSPeNc6XlaOPn6dfRfmN4QD+LW2eApk5qMiJ
WhaqDwKz5pCmoUDgCZu6yVhzGtUVdgo=
=LRs+
-----END PGP SIGNATURE-----

--sl2scc7rzqim4vqm--
