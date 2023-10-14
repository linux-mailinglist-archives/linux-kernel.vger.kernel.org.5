Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA747C91E0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjJNAsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjJNAsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:48:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC8CC0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:48:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24854C433C7;
        Sat, 14 Oct 2023 00:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697244494;
        bh=dpbZVQj3qMQmGsLiSL0zW/jwtunvrJ6WzsKrq001a2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bVeNFWnhtNla8x0bipU3oTrrZoZ8mGSJbKnVxj7szcsKdETMW2lgbVE7+8U7p/8Im
         tPtiPU6wKBYkLH5w5G6a6a2s/snBhvHm/utETKb0Exob+Tv5b0YfDkM+j/hdoA9cE9
         WkHoJHyDdKZuDUri4uwyFKDDvwnlzOokqCAa9wJlqEphYcSNVymPO6NAAc3aLFDjvd
         3I5WSWQHxrizOAbK737vtDITCrlqYLJ9VNMLvmAu7QHNQ0TTQs90K546/JnoYr+ttK
         ijvQSQ6y4Vjfr5yQwKRJ5UUF+jkMR/mLxbHg5wqtqGa7tlbYBrP2Imuwh9X+aHXVDZ
         HFOHrP8vTflNw==
Date:   Fri, 13 Oct 2023 17:48:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Mat Martineau <martineau@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jesper Juhl <jesperjuhl76@gmail.com>
Subject: Re: [PATCH net 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
Message-ID: <20231013174813.5ccc3744@kernel.org>
In-Reply-To: <20231013014010.18338-2-bagasdotme@gmail.com>
References: <20231013014010.18338-1-bagasdotme@gmail.com>
        <20231013014010.18338-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 08:40:08 +0700 Bagas Sanjaya wrote:
> Emails to him bounce with 550 error code:
> 
> ```
> 5.1.0 - Unknown address error 550-'5.1.1 <m.chetan.kumar@linux.intel.com>: Recipient address rejected: User unknown in virtual mailbox table'
> ```
> 
> It looks like he had left Intel, so move him to CREDITS.

The driver was very likely written by an entire team of people.
I wouldn't bother with CREDITS. Also I think you have the entry
in the wrong place. It's alphabetical by surname.
