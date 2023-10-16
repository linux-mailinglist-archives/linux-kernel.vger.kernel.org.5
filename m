Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7942C7CA69B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjJPLVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjJPLU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:20:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46CAEA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:20:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08B2C433C8;
        Mon, 16 Oct 2023 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697455255;
        bh=mBdvDnsY7j7n4KPIqkmfq1CVvQZIAOw4ayChHvb0b1A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b1nxnVkGRFf3ifXwoAneBYh5azomKc5q1gWJoqmKx9Im4iUcvTH0KE5Igu6uW9zwr
         DmlE3HJ/2jBodtXlSCjoTgDZwQAqoXv14MazmJ3+kz/pFnnTBMnos9gH78qx1vPsXd
         rrIPeLTFnLBUU0xQY2NdHtNL6zMohI4c3pywERdsvyI9aTflPCzZDfhGrCQ8hX/5XP
         az2A/CZJlZdcNN6cayE9hIO4JKOpeD7NkADXyJ06xEfkx3FjicKwh8DeD5I+qMsjYh
         fVIfHbPid98OdGET8H3ZY8Tc3UH2/QYa9ctR6ArUbNQ6Mcw5cO8iIscKyk/Ulh4y9u
         C023jLdU1OD2A==
From:   Vinod Koul <vkoul@kernel.org>
To:     alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20231013010833.114271-1-yung-chuan.liao@linux.intel.com>
References: <20231013010833.114271-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: dmi-quirks: update HP Omen match
Message-Id: <169745525335.217856.5702950620143710805.b4-ty@kernel.org>
Date:   Mon, 16 Oct 2023 16:50:53 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Oct 2023 09:08:33 +0800, Bard Liao wrote:
> New platforms have a slightly different DMI product name, remove
> trailing characters/digits to handle all cases
> 
> 

Applied, thanks!

[1/1] soundwire: dmi-quirks: update HP Omen match
      commit: 4ea2b6d3128ea4d502c4015df0dc16b7d1070954

Best regards,
-- 
~Vinod


