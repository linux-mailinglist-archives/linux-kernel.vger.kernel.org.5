Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF7B7A77B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjITJiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjITJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:38:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28D9F9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:38:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20F4C433C9;
        Wed, 20 Sep 2023 09:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695202681;
        bh=4uscOVD6TB53mRPO5QLLWGGIeKZl73p+kYRuHBF8CPU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GkC0eMxyy+wyIN9G52c4eO9x4bB/No/0Elz1CcOIoRE3OCf2b/uqWYC+wtTY3ZP0K
         dvOTTs47x4DTYN6yl1feb5FMwNGQfEddoFV9d3BPCXiPJqTZuDFx0meloUQuWrelG5
         wsFvNT081GNHx3hZ60rP5/Qkd1i0uH1Rwgoi2MhJXsPvZeDSkKFu5m6JfZRoQeZsWY
         OvpZHGtWBC2Tt9rt9aC/IfxHpOI7FYFZzoJbPE5Tk4Pn+oCXKMPNxDp9cFbgo4na0I
         RPl2yslQ0JVPwYiQbBphEBxFnCjKWVCqK+LJPZtwhL2YdE6rPqq1a0YLwUTfAGeVRA
         7yd5zi3t6+fxA==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <0789000f012122a7fa27ef709c738101b00cd834.1693407196.git.geert+renesas@glider.be>
References: <0789000f012122a7fa27ef709c738101b00cd834.1693407196.git.geert+renesas@glider.be>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: stericsson,db8500-prcmu:
 Spelling s/Cortex A-/Cortex-A/
Message-Id: <169520267972.3355646.4317395999770034810.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 10:37:59 +0100
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

On Wed, 30 Aug 2023 16:53:43 +0200, Geert Uytterhoeven wrote:
> Fix a misspelling of "Cortex-A9".
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: stericsson,db8500-prcmu: Spelling s/Cortex A-/Cortex-A/
      commit: 0235574f1ae5569a39e35de72767e42e03747bc0

--
Lee Jones [李琼斯]

