Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0133751064
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjGLSQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7516A12E;
        Wed, 12 Jul 2023 11:16:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 089D3618A6;
        Wed, 12 Jul 2023 18:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD02C433C7;
        Wed, 12 Jul 2023 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689185767;
        bh=hgSyj57PSSkmQ4SzQXTh2v+VzKV188lc3l9YbZGxClg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4Nu9woSFhd10RbYFsMr09XS+UiFQsMmCVh1CJEZe1f4IAmHxvkLUZJe3DcvMJH9k
         Oj2pqxkkeJy0SoooogHQEL8KAtOSIrhL+yHLrXLzU1U/uYbtU76lBEkPQ1HQxRG0TG
         ZmXl8WIWkq6HuAB2EI0lfOGEiYbW4Lozhvg5LsCFfuR1li1UEejHzQuvdnHe+1y8Sk
         q4uKlawba9i3iIW1ehRd/0h49XAhyfYeyhLUfsy2HWSnuwqBLoFk2UGS2PcAZg6Uet
         cB7fZ7DbI5TabRR12OnGhPjzM8JU4IzZPvvPyKZxtYWifFMHw76UnubQNXCxWnTSza
         sww6L6zdPkDvQ==
Date:   Wed, 12 Jul 2023 19:15:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Subject: Re: [PATCH v4 7/7] MAINTAINERS: Added maintainer details
Message-ID: <20230712-gangway-browsing-50a36df9e36c@spud>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-8-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uEmun1C0VPsOGrTO"
Content-Disposition: inline
In-Reply-To: <20230712121219.2654234-8-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uEmun1C0VPsOGrTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Noticed while looking at the DT patch,
	$subject: MAINTAINERS: Added maintainer details
Please at least say what you're adding maintainer details for.

Thanks,
Conor.

--uEmun1C0VPsOGrTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK7t3wAKCRB4tDGHoIJi
0sGnAQCjpa0m/IOYnNJOOM3cTiYZ9vtgnyjC5fTE1EshPaor3wEAozexmyRwP9Fx
b7dN56U1nh0nw4wwQFgFZvl+Wst8pQo=
=2mOu
-----END PGP SIGNATURE-----

--uEmun1C0VPsOGrTO--
