Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF5680167B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441849AbjLAWgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjLAWgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:36:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07F0D50
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:36:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC895C433C7;
        Fri,  1 Dec 2023 22:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701470171;
        bh=/ziQf+5NO5Nc/kK0ZRmDFpmb94z2MpSTFLqvRnV7wes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e8SRa3kLDpCQhadn6scBTbnyd1H6hNlIw09tjMaE2ZuY4lPrzglOv0o95FRZCEgkA
         6AZy9QJ5DuWLBqweN0cXaDmJHcRyXSNJjGq8LTWw6u0FWfq4aaKnYduhdqKOn4yPsb
         arMP5IfJbIsuHe0b44QdLqymk/aZB9Evq60y5lp0=
Date:   Fri, 1 Dec 2023 22:36:07 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Karina Yankevich <k.yankevich@omp.ru>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] usb: storage: sddr55: clean up variable type
Message-ID: <2023120110-uncharted-rift-98f9@gregkh>
References: <53bc0584-51eb-8bb7-de48-ca07fccafc19@gmail.com>
 <20230227112541.14849-1-k.yankevich@omp.ru>
 <Y/yaB2A8qwgRkqVO@kroah.com>
 <a1296b9a-c27e-3b35-e256-32350fb2a83e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1296b9a-c27e-3b35-e256-32350fb2a83e@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 07:16:56PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
>    Sorry for the really long delay! Your reply scared off Karina
> (it was her 1st kernel patch), so I'm trying to pick this patch up
> where it was left back in February...

Note, any submitter should be able to answer questions about their
change, as remember, if I take it I am now responsible for it.  If they
do not want to respond that means they do not want to be responsible for
it, which of course means we can't accept it :(

thanks,

greg k-h
