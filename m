Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF57778132
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjHJTR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjHJTR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:17:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635892702;
        Thu, 10 Aug 2023 12:17:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBE5566716;
        Thu, 10 Aug 2023 19:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF6FC433C7;
        Thu, 10 Aug 2023 19:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691695045;
        bh=BEW2jASDS4rCTYII7Gtbu6vmjY7RNQbJDS5D5sl005Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdQoAU1dMrq0CC8Q3kNXiSnzvj2R4RX8lDsbc/jr6avYjVr6yny1s+409UljpZJVj
         rW8zXfiyFnAllNfBg/63HqTh0aUZVvzKIiICTrtU9q+ubjb+UDNWIAppwTuFeFrIub
         KVtISknSQTPxMI0qNgTuchkTHVKMwuI4iZfLIM9NZI9rz3pzdVc6YqZOkVLPLSd4oj
         nz1ylRwoTxSBk2d8QaNNiyrJXhVdS3a8zLkXPvfILuu1VAdcEmbBQ10ylpxJrlk34q
         sWmPYL+jz3SsU4vWTaTT3vpzNZIWqZY59OFfUvUwX0b8ohyaYUHWIDViPF9rHfJ+hV
         i3vDoHRAG5E8g==
Date:   Thu, 10 Aug 2023 20:17:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add ShenZhen New
 Display Co.
Message-ID: <20230810-flaccid-unable-5b92d0403bb1@spud>
References: <20230810144116.855951-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KxGH0TYv7LlPmNgB"
Content-Disposition: inline
In-Reply-To: <20230810144116.855951-1-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KxGH0TYv7LlPmNgB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 04:41:14PM +0200, Luca Ceresoli wrote:
> ShenZhen New Display Co., Limited is the manufacturer of the
> NDS040480800-V3 LCD panel according the datasheet.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--KxGH0TYv7LlPmNgB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNU3wAAKCRB4tDGHoIJi
0uHmAP9xJDKYbXnFX6pwt4y4eKVct7i+zN97G50i09uVOi4CoQD8DTou+qPZK5kv
DfgGMq9q6XIF3iViQ1QpC/t7OzL9awY=
=qFX8
-----END PGP SIGNATURE-----

--KxGH0TYv7LlPmNgB--
