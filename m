Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BAF7DE3E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjKAPge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbjKAPgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:36:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DFF115
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:36:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1A9C433C8;
        Wed,  1 Nov 2023 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698852989;
        bh=ErDN5TGrf82/1e3WSBuxJ8Uwcx5pZO0mfLHGxApPH9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qoJpP3g3Xc50XgkT727p3w1Uw0bduzyGMMVFAwCS01GSz8AnKJL4TohyJNhngDdNm
         QG1fvGTDDtYj7x7XbY9kjPdSUQuBQFgnaAvUT1mFG9bREb38EbjUoh6S1opeaPJo6c
         b8saLZ95nsEKj5XUPUO9kBUwVcvMe9bUFYWCPvjdfQdorF0/xOGrjvlZpyd+bKDA9Z
         zBaXX3nccA8kwN/Hzzfjegl+zrOHpk7mmzoodODxWHeCSdgNqXXww+cAlk36UZ/5ou
         G67BUMFZjbHwIZ6RugYeZaSjWHZgX5FpKX77bsL3cu6wC61u4OwpyslNi6eMJ/pVAd
         It5TcDOx1Fptg==
Date:   Wed, 1 Nov 2023 15:36:23 +0000
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc:     Iago Toral Quiroga <itoral@igalia.com>,
        dri-devel@lists.freedesktop.org, Emma Anholt <emma@anholt.net>,
        Melissa Wen <mwen@igalia.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v3 3/4] dt-bindings: gpu: v3d: Add BCM2712's compatible
Message-ID: <20231101-whinny-observer-d0cae8d8d7c0@spud>
References: <20231031073859.25298-1-itoral@igalia.com>
 <20231031073859.25298-4-itoral@igalia.com>
 <d3ed80e5-b3a1-e9ba-48eb-7c6fc58ef3f9@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sKuyd3vh441A/Ew6"
Content-Disposition: inline
In-Reply-To: <d3ed80e5-b3a1-e9ba-48eb-7c6fc58ef3f9@igalia.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sKuyd3vh441A/Ew6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 02:53:35PM -0300, Ma=EDra Canal wrote:

> I would like to ask the device tree maintainers if you are willing
> to take this through your tree or should I push the entire series
> through drm-misc/drm-misc-next.

dt-binding patches almost never go through Rob's tree, usually that only
happens as a last resort if subsystem maintainers let them fall through
the cracks.

Cheers,
Conor.

--sKuyd3vh441A/Ew6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUJwdwAKCRB4tDGHoIJi
0jPJAP9aRVPsF33zF9+FSJjfCZPt69Z4e+uhPfQRnzhHZt0MJgD9GKPs7nkQVYGh
aY8i+yXw3l4Q8S1CVlbXYIOHIQXqFgY=
=A4c3
-----END PGP SIGNATURE-----

--sKuyd3vh441A/Ew6--
