Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37614805B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbjLEPe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346254AbjLEPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:34:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33CC19F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:35:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA2AC433C7;
        Tue,  5 Dec 2023 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701790503;
        bh=jxxlSiaaRyezQ6LzFH+4I6UqsA5xw8pyUZ9Qn3g/Aik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilL/AlxEv10rifhxB24AONRldMt8n7ncUkQmbUmqhJNG/5jBxUo+3xS4ZSQyhXD25
         PYJFQNsd3Z3hNcIq2F87nxy8EV7OnqLJNgUjN51xS6qH02FLT7abEFGvPTsI7rbl6h
         rDId+IZBN9Cd6P/nMU6jiEU8yTozxgYIhk1/6exgeNOtw21GfMgT7wMBuFeN9BvCcN
         vycoGXDlrkKnzQB0HRUz2knn660/0jxDz9iSxS3Ss3ZELoN5pRW+bIGZ4yWh+mc+NW
         h+qLCn4D7njLDo9MJ/aSCBHm93m6k2wc1v7X8TdhqwzQ3aBvxQjo3iFomIrEhavSwh
         yYAb2pTZo+VKQ==
Date:   Tue, 5 Dec 2023 16:35:00 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, frank.binns@imgtec.com,
        donald.robson@imgtec.com, matt.coster@imgtec.com,
        sarah.walker@imgtec.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v2 0/2] PowerVR VM fixes
Message-ID: <j6w6ccewlvoosop77ug56r3sqoi4hglj3ejkyfw4dj3s3pdsw5@b473njzq5u3d>
References: <20231129220835.297885-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="frqu6fpipq3ipztj"
Content-Disposition: inline
In-Reply-To: <20231129220835.297885-1-dakr@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--frqu6fpipq3ipztj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 29, 2023 at 11:07:59PM +0100, Danilo Krummrich wrote:
> Some major GPUVM changes landed just before v8 of the PowerVR series. Sin=
ce v8
> went in rather quickly (review process was finished otherwise) I haven't =
had the
> chance to review the subsequent code changes.
>=20
> Hence, this series with a few fixes in this context. Plus a minor GPUVM p=
atch to
> make the drm_gpuvm_prepare_* helpers useful for PowerVR.

This doesn't apply on drm-misc-next anymore, could you rebase and
resend?

Thanks!
Maxime

--frqu6fpipq3ipztj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW9DJAAKCRDj7w1vZxhR
xcnCAQC2Rnlt3ZS+eAeCOJ1rX+c3IzfC6+DAB7Ordkhc8HmZpAD/QcM1HDPb7Tzi
26TfeH0Ck+dr4dJGZF6YLiYxleZuPgk=
=poSS
-----END PGP SIGNATURE-----

--frqu6fpipq3ipztj--
