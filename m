Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C7F7A9924
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjIUSLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjIUSK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:10:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D086131;
        Thu, 21 Sep 2023 10:37:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C308FC4E760;
        Thu, 21 Sep 2023 14:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695306384;
        bh=0xfghWMedoSlx/QEomZwRWfF6s+XXddyyG2dWRAjylE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EkLApXW1gXrwyAaIXHRdvTXv3SfUvQba44REO1oVauxSzObWcZRClxcVaX3xSHW/O
         nrpPLOuOiJUiqfSRKgAtzd19NjihB40k3kdCJK2+nLFb4FC+npLKdx/UmBWqNnX3XF
         hxbULxlQ5QL2yH4/2A/f8+f3x+DYBuxOljlIwYF2WD38uJYql5yIKTEImWMiU1BvE0
         iaZocxM/PcdBS5anrbjt2lGNleLmYN1M+7LEGz8QJO1swuiAUO95JVAML1EqFHZTWQ
         G2FCccazx7Wxo7e/1hGuvoInLJdbhJrs+9MzpKX1Hd9jx/ZIcdYSk1/n7DKUubo9c7
         QeyJgOjNuLB2Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, Bo Liu <liubo03@inspur.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230912114646.8452-1-liubo03@inspur.com>
References: <20230912114646.8452-1-liubo03@inspur.com>
Subject: Re: [PATCH] phy: qualcomm: Fix typos in comments
Message-Id: <169530638251.106093.8189249588604640066.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 16:26:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 07:46:46 -0400, Bo Liu wrote:
> Fix typo in the description of the 'succesfully'.
> 
> 

Applied, thanks!

[1/1] phy: qualcomm: Fix typos in comments
      commit: 11395c32f9e9e26f2f6281bd916a1161ba42ee6c

Best regards,
-- 
~Vinod


