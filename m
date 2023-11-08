Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89337E601F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjKHVpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjKHVpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:45:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159F12589
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 13:45:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DEAC433C7;
        Wed,  8 Nov 2023 21:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699479944;
        bh=cH7mlZbv43X51KtintcGszNBNI0PO8LHj2oMnwGTrYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FEpEAMXf8doF+tfDtjvi9AmsQtZH8+bnQtGjswJXtT+Z184I2iuH9lfLfcN32mzoy
         S6/1KmFbGNc89nXz0Ep6ZJ5SqQBQYeqVO3n3GNWjDYkOZ6TxrOWF8eZ8JzkL9jZAVS
         0UGCRUaEm+IsxXiMqayd+f+lGEn4W5XwZTdEjrjbyBhZD8pjUVaEUvSa+ne9bn4FdO
         BLoZo3lHFLgIbQ/9wFrmZpS8xwVWFBH4jc6ZFngfYVGHBORfdXI62nE+J8Vgw7w3WM
         m8IGANTvbFG12S2KG0i5W3upQUE+7CzFqHQRvnW0IzQDzKpFF/KXLJ+6AIF2mMCo/A
         Q9kixAS+hVLdQ==
Date:   Wed, 8 Nov 2023 16:45:42 -0500
From:   Simon Horman <horms@kernel.org>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] indirect_call_wrapper: Fix typo in INDIRECT_CALL_$NR
 kerneldoc
Message-ID: <20231108214542.GA432024@kernel.org>
References: <20231107080117.29511-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107080117.29511-1-tklauser@distanz.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:01:17AM +0100, Tobias Klauser wrote:
> Fix a small typo in the kerneldoc comment of the INDIRECT_CALL_$NR
> macro.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Hi Tobias,

I am fine with this change but I don't think it fits the guidelines for
a bug fix. So I think it would be better targeted at net-next.

	Subject: [PATCH net-next] ...

If so, the following applies:

## Form letter - net-next-closed

The merge window for v6.7 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after November 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
