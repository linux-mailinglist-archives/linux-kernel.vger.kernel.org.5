Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657807D6929
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjJYKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjJYKlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:41:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477CA2129;
        Wed, 25 Oct 2023 03:41:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D77C433CD;
        Wed, 25 Oct 2023 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698230464;
        bh=ASn6oUNI1jODutGVOr50G10n8/QNJTsWdPoui+cZp3Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ign0ZnP6mlqnlJywAEn0JL/PY9rH1/Gey3RLpBXCFpkqtFcPfU7qvVvo/BXYQiU+q
         tf2vQI+lzB3KqP4ClHmdqBLwSna/E+Wk1ETYTX4g07MMVgN4lJv89qJPe/sbPLREaP
         pnubAvm4DDZBj60277dnTiIs3v9bw/ntdwCItwFO4sulJR8vn0t3vdvwEZgIjjV/Av
         EqPamK0Pg6VPoAXrqq0LLcpW9Nvujj79duIr7VCUN6eUStEgen0XCmkdBLpeEO3DlH
         ReD/rF30T4kZmCYWGE2RBEPYi8kiKxkOIy4yPE4L7w3yqIIYk5j6ERrLiQtD+rLKsm
         musVZBAsyEOrQ==
From:   Lee Jones <lee@kernel.org>
To:     pavel@ucw.cz, lee@kernel.org, Su Hui <suhui@nfschina.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <20231020091930.207870-1-suhui@nfschina.com>
References: <20231020091930.207870-1-suhui@nfschina.com>
Subject: Re: (subset) [PATCH] leds: lp5521: add an error check in
 lp5521_post_init_device
Message-Id: <169823046305.681001.11838368315958988376.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 11:41:03 +0100
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

On Fri, 20 Oct 2023 17:19:31 +0800, Su Hui wrote:
> lp55xx_write() can return an error code, add a check for this.
> 
> 

Applied, thanks!

[1/1] leds: lp5521: add an error check in lp5521_post_init_device
      commit: 13f0ccb77e98cc82c04db2c5fab984865666285e

--
Lee Jones [李琼斯]

