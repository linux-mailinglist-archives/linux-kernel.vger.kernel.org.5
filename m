Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C089B7786A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 06:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjHKEqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 00:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHKEqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 00:46:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868952722;
        Thu, 10 Aug 2023 21:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=yZ7xKDC9oogRyHnBgN1iW0v1uIAdYUKadGSsj2tAphk=; b=nQfa2CAXS2a+v5ZZFzqbCYJsfn
        cNvCOO/Vyfykt+Wyj2OR0tsQNJ/i6cZDB3RymnJKCVx/iEfnamTVWsTU0SUoPbdqbqtBvnsGDtWuA
        RvXgXwz6uCuGrmqNzgKdcJzjngXQQHYq106mAjIq3F5bDR1gAcLH9RjuJznkE3HA9huuwXminHce0
        NQZsHqbtkvr78V7OlTYyb8qerj3xEBHmUO0C+1BBmERQ2fcBx1+ssahlEZhTixcxyQQ1Jov1b1ACc
        cK8OK+yU6cqqugi8u+9RKzk38eSLzhX/+yI3R1BpKLiX+B/aqp0mcdekAbyk6yR38kgdaq/Plfm7U
        L8B5MwvA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUK2s-009OzV-0Y;
        Fri, 11 Aug 2023 04:46:42 +0000
Message-ID: <f95da2a4-996c-cd81-5ae1-715d33f577cc@infradead.org>
Date:   Thu, 10 Aug 2023 21:46:40 -0700
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <38f29379-4a8b-3cb0-c5dc-7cb4c8246fa4@att.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding postmaster@vger.kernel.org


On 8/10/23 20:53, Leslie Rhorer wrote:
>     Update: I finally managed to get a message through from my AT&T address to the linux-modules list.  I am not certain what the issue was before this.  I am still not sure what the issue is with the Majordomo, however.
> 
> On 8/10/2023 10:48 PM, Leslie Rhorer wrote:
>>      I know this is not exactly the right place to post this, but I am at a complete loss what else to do.  Please forgive me, but I cannot get the Majordomo at vger.kernel.org to respond to me.  I have tried everything of which I can think, but the Majordomo will not recognize when I send it the authorization command in order to try and include my siliconventures.net address in the linux-modules mailing list.  My att.net address is supposed to already be a member of the list, but whenever I send to the linux-modules list from mt AT&T address, the message bounces.
>>
>>      Thus , I seem to be having two issues.  The more immediate is I cannot get any messages through to where they need to go, both to the Majordomo and to the linux-modules list.  The more important long term issue is I am having a problem with the NIC card on one of my Debian Linux servers.

-- 
~Randy
