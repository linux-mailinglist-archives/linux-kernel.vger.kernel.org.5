Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4FF785B94
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbjHWPLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjHWPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B173DF;
        Wed, 23 Aug 2023 08:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07C4761073;
        Wed, 23 Aug 2023 15:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D70C433C8;
        Wed, 23 Aug 2023 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803469;
        bh=TzHe+GzNEPJVSERw9UXRys0AeK24GM+rfjy2pwhC8SY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYOhvtzFYHkzHqfF4poabAQ4QGZYQ8UJdGAe4nxLxkLy4l3lhV/RhALw6dWqWxzrg
         Fy6kmaluVAep4FbDQiAEt4q3HGesezIc54e2QkipJdH1fCoEFt7qukgFcBlCLB8oQ2
         CKpTURaacY/lQkvepC6F+PqBHiyUhkMoGJkj7ymN17hpHK2b7dogRk6Q+b+Dp7xbCP
         V3s4gs+h36EKwz1YC7pI+pUUjfwGB9Gg//mEjZoY5kWbPi6pUYOatNo55wwGpyCQz9
         2Rm7U3cAE3bMmNeUHuvo2GFDz7YBqi6TjosNnJMRDN+W0G40WwRwnopd2MJScK0UqY
         gUwN70EEKnarw==
Date:   Wed, 23 Aug 2023 16:11:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, dianders@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: add sc7180-lazor board
 bindings
Message-ID: <20230823-raving-either-fb7bdb98b846@spud>
References: <20230822094414.123162-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230822174101.v4.1.I26e017b00a341e7a5a2e94a83596923713408817@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yk9c07EgxSrwVLZG"
Content-Disposition: inline
In-Reply-To: <20230822174101.v4.1.I26e017b00a341e7a5a2e94a83596923713408817@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yk9c07EgxSrwVLZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 05:44:13PM +0800, Sheng-Liang Pan wrote:
> Introduce more sc7180-lazor sku and board version configuration,
> add no-eSIM SKU 10 for Lazor, no-eSIM SKU 15 and 18 for Limozeen,
> add new board version 10 for audio codec ALC5682i-VS.
>=20
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.googl=
e.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--yk9c07EgxSrwVLZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOYhiAAKCRB4tDGHoIJi
0sVkAP0dL5tBNctBejbbuRJ5KfR7AyHVb1R+yjPm8b7kOMrjIQD/cQOM85CP3O+e
/VwnpUgh7/CJZ82/K9ZHcvHTfN03qAI=
=NhKO
-----END PGP SIGNATURE-----

--yk9c07EgxSrwVLZG--
