Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4C7CFDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346189AbjJSP3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345450AbjJSP3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:29:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAE9121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:29:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947D6C433C7;
        Thu, 19 Oct 2023 15:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697729357;
        bh=mnkMhnk2axsXdxIeL67WcvwlgUar4Ez3CJz5UsKmSWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+EgP4klkp9IlAjGTjUhs25NdFju9Q6yF19kwoTv87UnqVdTH1UvqbEO6lPpuCLsL
         LHS+EXhddMZG8l1SVfXUgLzEx3IF4Txpb7fSem2KeHCaX4Ry5ETKEqL7LPP5BMPHnX
         HR6VaKyjl7hQlWPq3/um2w5VUG/a3ikdlDd34QSo=
Date:   Thu, 19 Oct 2023 17:29:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Ricardo B. Marliere" <ricardo@marliere.net>
Cc:     Calvince Otieno <calvncce@gmail.com>, gustavo@embeddedor.com,
        outreachy@lists.linux.dev,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: remove empty functions
Message-ID: <2023101908-bouncy-dandelion-da1e@gregkh>
References: <ZTD677iqMkRPxT27@lab-ubuntu>
 <qqvbqinun7wbhaz47i6sk2awplknwbrfutrwfpvj6wq4wgdie6@smhzxank6val>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qqvbqinun7wbhaz47i6sk2awplknwbrfutrwfpvj6wq4wgdie6@smhzxank6val>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:50:07AM -0300, Ricardo B. Marliere wrote:
> Hey there,
> 
> just as a heads up, the vc04_services staging drivers seem to be
> actively developed elsewhere [1]. I'm not sure how they plan to upstream
> their code later.

They are being actively developed here, one the staging list, whatever
out-of-tree stuff will come after all of the required fixes and cleanups
will get merged here and then the out-of-tree stuff can be added later.

So no need to worry about random github trees please.

thanks,

greg k-h
