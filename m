Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7337F7C8DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjJMTsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMTsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:48:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A427495
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:48:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587F5C433C7;
        Fri, 13 Oct 2023 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697226496;
        bh=smLVpenbHF8Flm0poW9y4kwQ6SQllmTRnsMnx7QCUwY=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=sRmvzBOEQL1uEGRflqP+uL7V9TASSYHkf7yJ2T6RbSsZo4/YD9M0K0OIgYYsf2fxc
         g+IlpDVHK7IGqPIcyGTnvk8u3+D21vUwrrmaPRdQY1VSRHl5tHmnRf2GdplOSVxAK4
         tS/A9IAEm3Yjjhf6z7jh+CPessHXnCZC6WRc4h7g2jvJDh1j0aR//cpoMnGBvdDomE
         +0ges718Ogu3ddbWZudOXzhXCBdbdug+txwwCMAEkOj/yBPGzn61HbtOrCb900u2h7
         mQhglpAZA78wrda5qoiAcnkGvWg7nubt3s2oDdLuLQtzo2Oy8Nlba8gJypTdSrmr46
         1TRL0avOCdNsQ==
Date:   Fri, 13 Oct 2023 20:48:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Enable UART6 on rock-5b
User-Agent: K-9 Mail for Android
In-Reply-To: <20231013193722.78630-1-tszucs@protonmail.ch>
References: <20231013193722.78630-1-tszucs@protonmail.ch>
Message-ID: <4DB8788A-4B0E-4C2E-A26B-3BB9FC50F612@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This email is encrypted, and I cannot read it=2E
See
<https://www=2Ekernel=2Eorg/doc/html/latest/process/email-clients=2Ehtml#p=
roton-mail>


On 13 October 2023 20:37:30 IST, "Tam=C3=A1s Sz=C5=B1cs" <tszucs@protonmai=
l=2Ech> wrote:
>
