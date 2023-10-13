Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF9C7C7D79
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjJMGJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMGJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:09:05 -0400
Received: from mail.andi.de1.cc (unknown [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DE5C0;
        Thu, 12 Oct 2023 23:09:02 -0700 (PDT)
Received: from p5dc58bc7.dip0.t-ipconnect.de ([93.197.139.199] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qrBLs-004u5D-Rg; Fri, 13 Oct 2023 08:08:48 +0200
Date:   Fri, 13 Oct 2023 08:08:46 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lee@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        mturquette@baylibre.com, sboyd@kernel.org, andreas@kemnade.info,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 4/5] clk: twl: add clock driver for TWL6032
Message-ID: <20231013080846.2422475f@aktux>
In-Reply-To: <20230916100515.1650336-5-andreas@kemnade.info>
References: <20230916100515.1650336-1-andreas@kemnade.info>
        <20230916100515.1650336-5-andreas@kemnade.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2023 12:05:14 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> The TWL6032 has some clock outputs which are controlled like
> fixed-voltage regulators, in some drivers for these chips
> found in the wild, just the regulator api is abused for controlling
> them, so simply use something similar to the regulator functions.
> Due to a lack of hardware available for testing, leave out the
> TWL6030-specific part of those functions.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
ping...

anything left to do here?

Regards,
Andreas
