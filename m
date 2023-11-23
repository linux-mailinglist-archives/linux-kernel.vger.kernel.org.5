Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296367F650F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345249AbjKWRRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjKWRRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:17:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FFCC1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:17:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B184FC433CC;
        Thu, 23 Nov 2023 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700759840;
        bh=eW+CaP4BT2sNRyEoRgqQyByj/UxBL0nOsR4Sy6KWAB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4+pi29bIwN67/0/212NMFo+i0rNMY2++XhQ3BSe0x7cAv7zqJlXtL4V3ReslEQW1
         XaJxbGtNBNmPyY5wGbWd9MSXUrCUN9q2c51w2+nQU2jwTmj5db8sJbgxyz4OlFbYQm
         Mf4kM1iB5+MKa/xpJUf9Sgc6waDiauIIuibWUXcwAyVO0RQc0St1TMbH7V7sOeF2eI
         hj/nu7RC4ckUBO0tgiVH+csJMCV9WN/OsoRMVF4AvKSG6LcZVetRPzE9zjBNBmgvVb
         nfJ8fdqaexbkuL0CIv/PXR5KjfjMohP6mPtkBP+pnqqOUI4vgTw5yDvwdoI4vkQO0W
         1cqkQ52sCsXFw==
Date:   Thu, 23 Nov 2023 17:17:14 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: display: mediatek: dsi: remove Xinlei's mail
Message-ID: <20231123-reply-runny-87d16e39f9f5@spud>
References: <20231123134927.2034024-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BrmG9mhQOAkPRD4C"
Content-Disposition: inline
In-Reply-To: <20231123134927.2034024-1-mwalle@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BrmG9mhQOAkPRD4C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 02:49:27PM +0100, Michael Walle wrote:
> Xinlei Lee's mail is bouncing:
>=20
> <xinlei.lee@mediatek.com>: host mailgw02.mediatek.com[216.200.240.185] sa=
id:
>     550 Relaying mail to xinlei.lee@mediatek.com is not allowed (in reply=
 to
>     RCPT TO command)
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--BrmG9mhQOAkPRD4C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+JGgAKCRB4tDGHoIJi
0pFxAQCyKVuk2eJSY49HrTBq2484vkMJ8MFxC/6EHrUG8IP+jQEAvJ6e6guZQQ5H
M4/Y0irGropjfjLwrA8b4j9bXOhM8AI=
=9maz
-----END PGP SIGNATURE-----

--BrmG9mhQOAkPRD4C--
