Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8558775426
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjHIHa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjHIH36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:29:58 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 723C82686;
        Wed,  9 Aug 2023 00:29:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 19A428105;
        Wed,  9 Aug 2023 07:28:48 +0000 (UTC)
Date:   Wed, 9 Aug 2023 10:28:46 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x-bone-common: Add GPIO PHY reset
 on revision C3 board
Message-ID: <20230809072846.GD11676@atomide.com>
References: <20230806085044.1917-1-wiagn233@outlook.com>
 <TY3P286MB26113797A3B2EC7E0348BBB2980FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB26113797A3B2EC7E0348BBB2980FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Shengyu Qu <wiagn233@outlook.com> [230806 11:51]:
> This patch adds ethernet PHY reset GPIO config for Beaglebone Black
> series boards with revision C3. This fixes a random phy startup failure
> bug discussed at [1]. The GPIO pin used for reset is not used on older
> revisions, so it is ok to apply to all board revisions. The reset timing
> was discussed and tested at [2].

Nice, should we add some Fixes tag for this so it gets applied to
the stable kernels automatically?

Regards,

Tony
