Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F73576D1E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjHBP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjHBP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:27:50 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1051759FA;
        Wed,  2 Aug 2023 08:25:40 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 23F4F1C0A93; Wed,  2 Aug 2023 17:25:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1690989908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ncnLa8RMFmo7lRLdSindECgykwSP9jOjY7A80oB7gtk=;
        b=k2vALqOu5IASQ//kXTIkQPaapH7MtQ1VwqBB2eOKvHXAv5sQi/GvpbKSUNXvfM8k8FR92l
        xTow1gNIcXsnIZt/DFY/17eQ2AYcb9VgE0qRgfwFOokyUA1fTQGqfqfHvfiTh1LlSssg6E
        l0j6k55NHwPgTZALJi+dXwWPzNMYq1o=
Date:   Wed, 2 Aug 2023 17:25:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: qcom: msm8939-longcheer-l9100: Add
 initial dts
Message-ID: <ZMp1Ux3EBUwp6R4i@duo.ucw.cz>
References: <20230724-bq_m5-v1-0-17a0870a73be@apitzsch.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5DzgMCPiq2tUAg7f"
Content-Disposition: inline
In-Reply-To: <20230724-bq_m5-v1-0-17a0870a73be@apitzsch.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5DzgMCPiq2tUAg7f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This dts adds support for BQ Aquaris M5 (Longcheer L9100) released in
> 2015.

Thanks for the patches. Please cc phone-devel@vger.kernel.org with
phone patches.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--5DzgMCPiq2tUAg7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZMp1UwAKCRAw5/Bqldv6
8p0qAJ9CxdRe3MDuZuyFDWEQ3tzMrvgoNACfQUHvvF+n4piXGKayoWPszlGJQis=
=p3Fy
-----END PGP SIGNATURE-----

--5DzgMCPiq2tUAg7f--
