Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090ED7A40AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbjIRFvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjIRFvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:51:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC5A3;
        Sun, 17 Sep 2023 22:51:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0DDC433C8;
        Mon, 18 Sep 2023 05:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695016275;
        bh=JfOWIt+obf76s+1uVLbbOkwuyYHQs3sah4CV1tI8N78=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bjVywE1vRCCmIvADzHZlgW06bbzuIEiWHOy4fNTHae3zudLd7PTBZdvz9LSAQNazc
         0RqItXqcGRWyrZwKsnHwSpzlTbL6/fJN5ItZpYwasR8C/m8Ukz0wq2qA90UgaJksYo
         EOcT/YnUZR/vcuh+XWxq/QjkTs7oTikrZUhxfJ140Px5EsVXgzHiKtbfHlpiaRRF2t
         AoNuKFJq80lo4xxD96KHRX9nc4gS2NTXgW1N+bumGAqojFbpsDqWGqZBL12iCQxE7s
         JqEf0O8fv4izP/Vx4Wwh6saVMu8g4BWOZHMjcC1pAropK7Y3VgTegrH0XNtDwRAtRA
         bQLkjSwlFoSnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8729CCE093C; Sun, 17 Sep 2023 22:51:11 -0700 (PDT)
Date:   Sun, 17 Sep 2023 22:51:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Charles Han <hanchunchao@inspur.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: RCU: Remove repeated word in comments
Message-ID: <6f30a570-670d-4fb3-bddb-5cb129dc7af6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230918031309.142170-1-hanchunchao@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918031309.142170-1-hanchunchao@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 11:13:09AM +0800, Charles Han wrote:
> Remove the repeated word "of" in comments.
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Good eyes!  Queued and pushed, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/torture.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
> index b3b6dfa85248..49e7beea6ae1 100644
> --- a/Documentation/RCU/torture.rst
> +++ b/Documentation/RCU/torture.rst
> @@ -185,7 +185,7 @@ argument.
>  Not all changes require that all scenarios be run.  For example, a change
>  to Tree SRCU might run only the SRCU-N and SRCU-P scenarios using the
>  --configs argument to kvm.sh as follows:  "--configs 'SRCU-N SRCU-P'".
> -Large systems can run multiple copies of of the full set of scenarios,
> +Large systems can run multiple copies of the full set of scenarios,
>  for example, a system with 448 hardware threads can run five instances
>  of the full set concurrently.  To make this happen::
>  
> -- 
> 2.31.1
> 
