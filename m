Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7FC7E8214
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbjKJS41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjKJS4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:56:11 -0500
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E940BDFCA8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:18:02 -0800 (PST)
Received: (wp-smtpd smtp.wp.pl 29461 invoked from network); 10 Nov 2023 19:17:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1699640260; bh=SRemD7ATOG5CKdg6YqeS6p3TXJ4d7U2VT5o0fVjjsH0=;
          h=From:To:Cc:Subject;
          b=x9kYakAOlEr+2zJA6fltu+NDjbm6VuykcfbdCiXBZ6VHkHUUS8AsIGKnMKwF4ouRn
           lpo4oTBTnQZSsmYv6TGj0olH786/fJiCP8+w/jpOp01nzgLnR7CIdw9bEZBtZMCPBH
           RMdeUSklHVtJnapx8u8CtNQCysJQCWYGA2Q7XoSY=
Received: from 89-64-13-111.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.111])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <jiapeng.chong@linux.alibaba.com>; 10 Nov 2023 19:17:40 +0100
Date:   Fri, 10 Nov 2023 19:17:39 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] iwlegacy: Remove the unused variable len
Message-ID: <20231110181739.GA145985@wp.pl>
References: <20231110073602.16846-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110073602.16846-1-jiapeng.chong@linux.alibaba.com>
X-WP-MailID: fbed809173fc10fc8f89dd4615c66423
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gTNk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 03:36:02PM +0800, Jiapeng Chong wrote:
> Variable len is not effectively used, so delete it.
> 
> drivers/net/wireless/intel/iwlegacy/4965-mac.c:4234:7: warning: variable 'len' set but not used.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7223
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
