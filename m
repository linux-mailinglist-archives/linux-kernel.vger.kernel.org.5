Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B97B1ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjI1NoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjI1NoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:44:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1A719E;
        Thu, 28 Sep 2023 06:44:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9515EC433C8;
        Thu, 28 Sep 2023 13:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695908647;
        bh=RhAlUo+HqoVRaYK6G24Q7rb0UzNyJAM9gfrJL5vyvKU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QjfrV2SJeMZ/O/nNLuyAXZGirZ2KXPTfcQ6OrLGH7AOzn0oZqZEBWhB+veT5Dvq3Z
         V7c+3WDHZdcfTKFIS6lGpen7SKYL8A7EIKWUZXmbGNfk/MLs+rxao+/VY36idaLyPA
         p57tW/jK1zlpOUyYUjri2FYODol/k3LC8nzIPWosZTv1KpIcq9bMF0SpjpWfH9rcBx
         tcFMXveTzUmjmOPjQCkB+TUeJgCgknpnFLOTbYfaHshbNO8tt7sJIqOylx/5xZgVQV
         DICUgduiGnhBlrJIVopId5HTsIBIn6P+RLQ2wBIEa8RbzOUKxThq13rAl/1Rv551nP
         EDdQQlORBoYww==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230923171921.53503-1-biju.das.jz@bp.renesas.com>
References: <20230923171921.53503-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 0/2] Match data improvements for pca955x driver
Message-Id: <169590864634.1606171.10041849429299000003.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 14:44:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2023 18:19:19 +0100, Biju Das wrote:
> This patch series aims to add match data improvements for pca955x driver.
> 
> This patch series is only compile tested.
> 
> v1->v2:
>  * Added Rb tag from Lee Jones for patch#1.
>  * Adeed patch#2 for cleanup of OF/ID table terminators.
> 
> [...]

Applied, thanks!

[1/2] leds: pca955x: Convert enum->pointer for data in the match tables
      commit: 734adca71b2ccc6df12c244037e0b284aab7cf58
[2/2] leds: pca955x: Cleanup OF/ID table terminators
      commit: e1f9ce22d669bc53210d1c1017f96eeef067b034

--
Lee Jones [李琼斯]

