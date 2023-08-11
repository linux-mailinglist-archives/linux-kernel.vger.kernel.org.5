Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA5779558
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjHKQzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjHKQzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:55:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69192D7F;
        Fri, 11 Aug 2023 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=BSn+1riio2Wpa2BGBaQccHRcnWuqa9fih+8qtSIWOEI=; b=isTaSHhrJRAiw8NHeJ/9wXdeyz
        hEiPSbgewBcxmhs44Sag4YfuDoSMIrSmE3jJZt2Hv5qoyascwbLNSnZkuTsm0sYGCIi+3jUNj0Dvf
        8XKaX+l+GMB6SzgibYrYZ3ara3PPlnrtU4sZCEBx13KPPV/7gYUju4b0MJNM8dDbWqXVbjOhz3nxJ
        TWqXp+x9ifizEwWwPxcWh02kJjZXD4yGvKMwb/lSo+S3MIXrekASc/vXcdvb0OuDb3X1q7aiGAtKD
        BC2GKY5ZjIp5EL6Ual6flX+YwRicbvG0iWSHHOzkGF80OHoxoSeCZesXHLuJXWQfUR7robq3TmIP3
        7FQQv0ww==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUVQS-00BAXW-0U;
        Fri, 11 Aug 2023 16:55:48 +0000
Message-ID: <a50a9929-936d-4b4c-0f37-ea5082b96af9@infradead.org>
Date:   Fri, 11 Aug 2023 09:55:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Majordomo not working
Content-Language: en-US
To:     Leslie Rhorer <lesrhorer@att.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        pmladek@suse.com
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        postmaster@vger.kernel.org
References: <Y9BIU5SGOS6YEdSh@bombadil.infradead.org>
 <06bc7efa-c486-f995-a73c-3f1dd6a5ce64@att.net>
 <38f29379-4a8b-3cb0-c5dc-7cb4c8246fa4@att.net>
 <f95da2a4-996c-cd81-5ae1-715d33f577cc@infradead.org>
 <38c4f2b5-4585-c1c6-cc07-fc41b4dbca94@att.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <38c4f2b5-4585-c1c6-cc07-fc41b4dbca94@att.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/23 09:51, Leslie Rhorer wrote:
>     I had a friend of mine attempt the same thing using Outlook, and it is also bouncing all the messages.  It looks like Majordomo may actually be broken.  It seems like it may not have been updated in 20 years.  Can anyone else sign up for a conference using Outlook or Thunderbird?
> 

Hi,
I don't know what "conference" means here, but I use thunderbird all of the time.

> On 8/10/2023 11:46 PM, Randy Dunlap wrote:
>> Adding postmaster@vger.kernel.org
>>
>>
>> On 8/10/23 20:53, Leslie Rhorer wrote:
>>>      Update: I finally managed to get a message through from my AT&T address to the linux-modules list.  I am not certain what the issue was before this.  I am still not sure what the issue is with the Majordomo, however.
>>>
>>> On 8/10/2023 10:48 PM, Leslie Rhorer wrote:
>>>>       I know this is not exactly the right place to post this, but I am at a complete loss what else to do.  Please forgive me, but I cannot get the Majordomo at vger.kernel.org to respond to me.  I have tried everything of which I can think, but the Majordomo will not recognize when I send it the authorization command in order to try and include my siliconventures.net address in the linux-modules mailing list.  My att.net address is supposed to already be a member of the list, but whenever I send to the linux-modules list from mt AT&T address, the message bounces.
>>>>
>>>>       Thus , I seem to be having two issues.  The more immediate is I cannot get any messages through to where they need to go, both to the Majordomo and to the linux-modules list.  The more important long term issue is I am having a problem with the NIC card on one of my Debian Linux servers.
>>

-- 
~Randy
