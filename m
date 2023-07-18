Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354A9757A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGRLYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjGRLYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:24:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF5C1701;
        Tue, 18 Jul 2023 04:24:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62A4361524;
        Tue, 18 Jul 2023 11:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8F7C433C8;
        Tue, 18 Jul 2023 11:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689679470;
        bh=JRwdY5Kht7efaefdL+6X58dgoVjVQFMxAAZQII9r9us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVGuaN1FbdUIblV7AgIBLxeRuavW0GTinYFRjUPw6EjBTUSsLgaa75+Yh0dQOJx8E
         ZHp89bzJjOCPvED4zWz44WtBWgMe05i/WIcbIO4FnKUIqjne3JWMb7MxRT/JJVKOy8
         4yWsUQNT2JWMQvijsXc+G3+eIFFTVIHnySbqahq98j87fkb/Q3LbjBvn4/iI43TDqi
         9/wo1bd1AI07EcfpPLcPWIYRhZ7mfYfW7x4FuAwwU6iMEFjPbIsuxqLf6mU4AtUsfs
         /XDm3wdFISriTpFwVQQLjUIHKrTQbv72dGY2gOvk4MtxSPpYme7FLm37JE1HZ9GAWE
         DXxivT+/jK7yg==
Date:   Tue, 18 Jul 2023 13:24:27 +0200
From:   "mripard@kernel.org" <mripard@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Binns <Frank.Binns@imgtec.com>,
        "conor@kernel.org" <conor@kernel.org>,
        Sarah Walker <Sarah.Walker@imgtec.com>,
        "luben.tuikov@amd.com" <luben.tuikov@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "matthew.brost@intel.com" <matthew.brost@intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "hns@goldelico.com" <hns@goldelico.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "afd@ti.com" <afd@ti.com>, "dakr@redhat.com" <dakr@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Donald Robson <Donald.Robson@imgtec.com>,
        "faith.ekstrand@collabora.com" <faith.ekstrand@collabora.com>
Subject: Re: [PATCH v4 02/17] dt-bindings: gpu: Add Imagination Technologies
 PowerVR GPU
Message-ID: <qdrecp36jp34rrfwrrse4t7q626smyfddgzeozfjaovhemwoxa@nkg5ihejtzsr>
References: <20230714142526.111569-1-sarah.walker@imgtec.com>
 <20230715-paramount-straining-6a486f8af20d@spud>
 <a86f6359706485cf595889a07e513e2b9fd6d71b.camel@imgtec.com>
 <4131759e-9474-48f6-cc05-67b6d4b6559b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5n2dbrajkhgku5s"
Content-Disposition: inline
In-Reply-To: <4131759e-9474-48f6-cc05-67b6d4b6559b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5n2dbrajkhgku5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

To expand on what Krzysztof said

On Tue, Jul 18, 2023 at 01:10:14PM +0200, Krzysztof Kozlowski wrote:
> On 18/07/2023 13:08, Frank Binns wrote:
> >> And this
> >> items:
> >>   - const: gpu
> >> can just be
> >> const: gpu
> >>
> >> Although, if there is only one interrupt this is probably not
> >> particularly helpful. Are there other implementations of this IP that
> >> have more interrupts?
> >=20
> > No, all our current GPUs just have a single interrupt. I assume it's mo=
re future
> > proof to keep the name in case that ever changes?=20
>=20
> Why do you need name in the first place? If there is single entry, the
> name is pointless, especially if it repeats the name of the IP block.

Generally speaking, if there's only one resource (interrupt, clock, etc)
we don't put any discriminant.

If you need to extend it later on for some reason, then you'll add an
interrupt-names property and you can either require it for that new GPU
or whatever, or fallback on the nameless on if no name was found.

> > As in, by having the name now
> > we can make it a required property, which I guess we won't be able to d=
o at some
> > later point.
>=20
> Why even making it required?

There's no issue with introducing a new property later on if a GPU needs
it. Then, you can either make it required only for that particular
generation, or you can have some fallback case.

Both are fine and easy to do.

Maxime

--b5n2dbrajkhgku5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLZ2awAKCRDj7w1vZxhR
xa5SAP9utBZxY/awdllxhKZ1cNxNw5Zy6auh5hgXK6ulOQUFkwEA0PHNZyhc2oHW
PzI0e+UqBJvc1u6xggP6JTnqAwhs5A8=
=q26+
-----END PGP SIGNATURE-----

--b5n2dbrajkhgku5s--
