Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCEB76B43C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjHAMAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjHAMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:00:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A672708;
        Tue,  1 Aug 2023 04:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2F7761583;
        Tue,  1 Aug 2023 11:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB31EC433C8;
        Tue,  1 Aug 2023 11:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690891160;
        bh=6AHpkW+1Vl/pIzsm+KzIZOLB+nxZCt4ZJydu7QiZDjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvKF6P7N0m3zB0nnePyxPnqDHStcVAcph1SwLx0+grePPtgnTZkfrH+Fplm7rCBKp
         h3n0nQ/UsSvLX8Plk1e3UVqTo8ZwD+N+zyEellIcLUP9sD8c8+x6xNeZhcXv62Tu7Q
         KSMbKT2G3GaS+fnhS5MrjdxtvBM4fyxEZQuJNPoR2prZrNgo0D2Y/WtFiOQP0q0oby
         AOUofNC93tdVQ4juvzFjTgPfP6pDdobkv8ule29qz6CY95lirubFicboI7WUE7QY6Q
         D8FR7qkTgvU+bULj8KDUb/Y7T0Qrl+01Zo/MrswIU5jeQ4pzh7JkVzjcMnmWlDSxoE
         vg8kR/Vw1bvOg==
Date:   Tue, 1 Aug 2023 13:59:17 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Keith Zhao <keith.zhao@starfivetech.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com, Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: Re: [PATCH v1 v1 7/7] drm/vs: Add hdmi
Message-ID: <gkavtc4qkwwgpre5to4sjvd3e6s3a2mo6qoychxid6buiu2c2v@xx47v5erxsvn>
References: <20230801101030.2040-1-keith.zhao@starfivetech.com>
 <20230801101030.2040-8-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3xwzbtwdfjoxzmbg"
Content-Disposition: inline
In-Reply-To: <20230801101030.2040-8-keith.zhao@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3xwzbtwdfjoxzmbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 01, 2023 at 06:10:30PM +0800, Keith Zhao wrote:
> add hdmi driver as encoder and connect
>=20
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>

You've ignored most of the comments I made on the previous version, so
please go back to that mail and fix everything you've ignored.

https://lore.kernel.org/dri-devel/ayygsdwzogu4ygkobs7zkroxicxtixtp5bxayn5vz=
k4qlkwt6x@yo5s2qwt77mo/

Maxime

--3xwzbtwdfjoxzmbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMjzlQAKCRDj7w1vZxhR
xW+vAP9NEuZQurYGyBDJt6E4rkErtbkDJOx6fO0bKpk2+IjzDwD/eSkZ7tV0bwjK
r1MKgVz2slSLf3AktsOtIlI162uxrQ4=
=9TvY
-----END PGP SIGNATURE-----

--3xwzbtwdfjoxzmbg--
