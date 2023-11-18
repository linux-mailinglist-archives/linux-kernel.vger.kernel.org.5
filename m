Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643457EFC88
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 01:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346376AbjKRA0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 19:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjKRA0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 19:26:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E472310C6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:26:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F43C433C7;
        Sat, 18 Nov 2023 00:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700267199;
        bh=GSskpSkb+gqp7Ilh5CwUXkWbfmd9WvqPk0X0bLR5x60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p1U5NexMi9d6MmNo06+HGgtQWdWWQOYW3+//xMvP1lzjOS1GdyYhkRVH/MSbNcz9V
         QtuJ2PXISDTfIxjBOlcwzYC5WOyWTR0qEH6Y1gem5Xi/lmkRjFo7pMqJ92RV8TO5Z1
         Qzl3U9k2b/hvE1G5pNe8VzDTPy9CnIhECBwhx0M8pwxkTY76er2YBGWGAkyn6f/UDU
         rSuJDtTjfagGUBeQcpyu8XypxSQGcZGSAOKqcQusTdjWwaOna6dOYVG2fZtS/i61R1
         QC3zy2ETnJdpFAqVjgK5zpc+4weFZq7d2vlwQDKiWvrdNglCYGQC/sllPBIbwpF7RI
         fiqsujy/KWNhA==
Date:   Fri, 17 Nov 2023 16:26:38 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
Message-ID: <20231117162638.7cdb3e7d@kernel.org>
In-Reply-To: <20231117070602.GA10361@thinkpad>
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
        <20230607094922.43106896@kernel.org>
        <20230607171153.GA109456@thinkpad>
        <20230607104350.03a51711@kernel.org>
        <20230608123720.GC5672@thinkpad>
        <20231117070602.GA10361@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 12:36:02 +0530 Manivannan Sadhasivam wrote:
> Sorry to revive this old thread, this discussion seems to have fell through the
> cracks...

It did not fall thru the cracks, you got a nack. Here it is in a more
official form:

Nacked-by: Jakub Kicinski <kuba@kernel.org>

Please make sure you keep this tag and CC me if you ever post any form
of these patches again.
