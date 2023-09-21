Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126F77AA4F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjIUW0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjIUWZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:25:35 -0400
Received: from out-225.mta0.migadu.com (out-225.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978147ED4;
        Thu, 21 Sep 2023 10:05:38 -0700 (PDT)
Message-ID: <83d2d685-3c3e-1758-55f7-6c829957e51d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695307305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4F2fUPcR6NfJ9mAonWAyFBxw+y/d1QPP6AzZ+x+r3A=;
        b=FGYzkQEnCvr/opzfYOz86RJUtsE+p4cbQ1uePHwU1FuJipkFC8Zvor9BEatrhPYJyMQcai
        d4Y/oA4rVKCyx5STvMJN6C1ggz1j9m2F0ta5DChEfkS0NFjs91q7vcke5jtw8OYBft0VBn
        HdCPEkdKu4/74UtNrjyQDPSqIL6ITZA=
Date:   Thu, 21 Sep 2023 15:41:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH net-next] netdev: Remove unneeded semicolon
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        arkadiusz.kubalewski@intel.com, jiri@resnulli.us
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230919010305.120991-1-yang.lee@linux.alibaba.com>
 <0ae9f426-7225-ac4b-4ecd-d53e36dbf365@linux.dev>
 <b638de8abaa2e468bbcda116368c8e690a461a5d.camel@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <b638de8abaa2e468bbcda116368c8e690a461a5d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 14:07, Paolo Abeni wrote:
> On Wed, 2023-09-20 at 12:10 +0100, Vadim Fedorenko wrote:
>> On 19/09/2023 02:03, Yang Li wrote:
>>> ./drivers/dpll/dpll_netlink.c:847:3-4: Unneeded semicolon
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6605
>>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>>
>> Hi Yang!
>> There was a report from Intel's bot too about the issue, could you
>> please add the tags from it?
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202309190540.RFwfIgO7-lkp@intel.com/
> 
> No need to repost, the pw tools import the above tags automatically. 

Ok, cool.

The fix itself is trivial.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
