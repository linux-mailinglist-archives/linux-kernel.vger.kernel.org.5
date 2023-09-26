Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F47AF18E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjIZRJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIZRJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:09:12 -0400
X-Greylist: delayed 4985 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 10:09:03 PDT
Received: from mx1.supremebox.com (mx2-c1.supremebox.com [198.23.53.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABB0127;
        Tue, 26 Sep 2023 10:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jilayne.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QpVqjqaIqyh1bD1+m2fo7n8+tqggRTSMwKBxxg++NTo=; b=A8URxLyWVgqMPJr7O4urR9cRow
        cZu/k6/VJvIMjUaRID8TXXWgvUzXA+HiNQOie93yAV36xPPNe7pMGzSb+XbknE25vdH7C693bljJZ
        oyipmip4a2Lh/4u7qzDC0q4qaKjOZx/wQrz+gyyyo6ZGtBFl3vDfzE3/ZWWw/Lr4i9Ik=;
Received: from 71-211-134-218.hlrn.qwest.net ([71.211.134.218] helo=[192.168.1.151])
        by mx1.supremebox.com with esmtpa (Exim 4.92)
        (envelope-from <opensource@jilayne.com>)
        id 1qlAG3-00023a-Lu; Tue, 26 Sep 2023 15:45:55 +0000
Message-ID: <7fc54cc9-a53a-46ba-9f16-02d8c638dd26@jilayne.com>
Date:   Tue, 26 Sep 2023 09:45:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SPDX: Appletalk FW license in the kernel
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Prarit Bhargava <prarit@redhat.com>
Cc:     Dave Miller <davem@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, jschlst@samba.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
References: <6100798b-ab1d-262a-fd5b-435d6dfc4a53@redhat.com>
 <ZRKJa+cMsFxiizKb@infradead.org>
From:   J Lovejoy <opensource@jilayne.com>
In-Reply-To: <ZRKJa+cMsFxiizKb@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Ident-agJab5osgicCis: opensource@jilayne.com
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 1:34 AM, Christoph Hellwig wrote:
> On Fri, Sep 15, 2023 at 09:39:05AM -0400, Prarit Bhargava wrote:
>>
>> Is there anyone you know of that we could approach to determine a proper
>> SPDX License for these files?
Answering this question generally, even though it sounds like it wasn't 
needed for this particular situation:

YES! If you find a license in the kernel that does not match a license 
already on the SPDX License List and want to submit the license for 
inclusion on the SPDX License List (which, if accepted, means the 
license will get an SPDX id assigned), please follow this process: 
https://github.com/spdx/license-list-XML/blob/main/DOCS/request-new-license.md

By the way, people on the linux-spdx list may be interested to know that 
Fedora has adopted the use of SPDX license ids in the license field of 
Fedora package metadata. There has been close collaboration between the 
two projects, which has resulted in 95 licenses or exceptions added to 
the SPDX License List so far. I think this is a great thing (even if a 
lot of work) as it is making the SPDX License List more reflective of 
the reality of open source software licensing (including all the 
variations on old permissive licenses).

Jilayne
