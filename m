Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B341A7D24F3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjJVRbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVRbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:31:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771F5E5;
        Sun, 22 Oct 2023 10:31:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B6BC433C8;
        Sun, 22 Oct 2023 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697995868;
        bh=xIa81NLUBml5MoS2Eb3kkSqN1ZIghfNeP9hiSlzUH1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzAt1VabW6duveqB+z3dICSEWrqt9VsVnC0iGerJXDVutrrQ3RPrvRAb17u/S4miQ
         AR0wwKAyW+F3mbb1M9COYxgh3b1h2pLza2D9VUc3LpW2edvGjMsw1F0fgwOnU4YExb
         vQ8GKVmWOCcKGtGECvOb68yz+p+8HjHzXOdURqwjuFYnrfSUIUKqDs0e2VsDJ5XyAX
         IElUICMjwaB3hrzS9SfdIV7hqHuR3Q1PbDXdfU2BIpKZYFomxCV07vgn7SRdAYxIIC
         qi1tm0ffkcJ4BLKpKti+UqrL8srAGFS6d0kZ64b+sGuEih/DXeVP02rGaIrSF4KY1P
         jC+1JkrxllYng==
Date:   Sun, 22 Oct 2023 18:31:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     lukas walter <lukas.walter@aceart.de>
Cc:     agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add Huawei Honor 5X / GR5
 (2016)
Message-ID: <20231022-sequester-atypical-325eadda7a15@spud>
References: <20231022-arousal-glowing-f72c8f2e44fa@spud>
 <fc5234cd33b78369f792479795abd02710dfcdbf.camel@aceart.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RN7U2wqAnTB6dxtW"
Content-Disposition: inline
In-Reply-To: <fc5234cd33b78369f792479795abd02710dfcdbf.camel@aceart.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RN7U2wqAnTB6dxtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 01:40:41PM +0200, lukas walter wrote:
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> >How come this v1 has an ack?
>=20
> This is supposed to be a v2, but I had problems sending it correctly,
> sorry
> https://patchwork.kernel.org/project/linux-arm-msm/patch/20230916134147.1=
63764-1-lukas.walter@aceart.de/

The joys of email, ehh

--RN7U2wqAnTB6dxtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTVcVwAKCRB4tDGHoIJi
0jJvAP4+ghdIssWpblmMi9YkVOa7s1TtwnvzXBODtTruht2GyQD/ewbu+P/6wDqx
0A0ZZrh0Z3J/IfGnZcwNsjK3VxxvCgI=
=XBcM
-----END PGP SIGNATURE-----

--RN7U2wqAnTB6dxtW--
