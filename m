Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826F97CED91
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjJSBWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjJSBWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:22:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F310130;
        Wed, 18 Oct 2023 18:22:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AF1C433C9;
        Thu, 19 Oct 2023 01:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697678551;
        bh=Grh3jo+7tkGoKyq9Pq7yYPS6tSBALvJgRtmJP6V1Iu8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JwMG1wmrC/cc9FNHjmFS+Sv9KsxizyEok7Pr8LSdngNEXOwMIkC3O63f7TjdBiN8/
         Jo+qi496X+6y5sSPKi/n7HJiBA3kXQrXSWPqaJ5hhNfOGv0l06r+bvzvoeALDLaUC5
         XK6A43GLPVKvBYeYwIn3reofyflNfoeiqfN9DGA2uKTvCTZw8PSsuoeu0vAw0+GiPo
         xpktZV7NYlcX8ywaDgg8NWutk23au3qzwip9dyWavroVjmguH99z/jjtr9wD/8poFU
         3PBNqcAzwFcF+lPGSJmvxSsa6swNHVI2dKtp+9JeIkn0XOkm0i7Df+3NFx1eP+KlvJ
         C1OITYZbcaWIw==
Message-ID: <79d055616b57e661ef35ccc166cae697.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230916100515.1650336-3-andreas@kemnade.info>
References: <20230916100515.1650336-1-andreas@kemnade.info> <20230916100515.1650336-3-andreas@kemnade.info>
Subject: Re: [PATCH v4 2/5] dt-bindings: mfd: ti,twl: Add clock provider properties
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>
To:     andreas@kemnade.info, bcousson@baylibre.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, tony@atomide.com
Date:   Wed, 18 Oct 2023 18:22:28 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andreas Kemnade (2023-09-16 03:05:12)
> Since these devices provide clock outputs, add the corresponding
> property.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
