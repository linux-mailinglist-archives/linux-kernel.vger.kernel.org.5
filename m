Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18957F3E93
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbjKVHFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjKVHFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:05:44 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ACE110;
        Tue, 21 Nov 2023 23:05:39 -0800 (PST)
X-UUID: c4ecf16c6ac744a6bd74b93463420173-20231122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:646ed184-da94-4180-af12-41e1c93f27bb,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.32,REQID:646ed184-da94-4180-af12-41e1c93f27bb,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:5f78ec9,CLOUDID:38365860-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:2311212011149OSNONXV,BulkQuantity:4,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c4ecf16c6ac744a6bd74b93463420173-20231122
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 572602639; Wed, 22 Nov 2023 15:05:32 +0800
Message-ID: <9b4d2367-97af-4e44-80aa-e591022afeb6@kylinos.cn>
Date:   Wed, 22 Nov 2023 15:05:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ipv6: Correct/silence an endian warning in
 ip6_multipath_l3_keys
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>, edumazet@google.com
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        kunwu.chan@hotmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <CANn89iKJ=Na2hWGv9Dau36Ojivt-icnd1BRgke033Z=a+E9Wcw@mail.gmail.com>
 <20231119143913.654381-1-chentao@kylinos.cn>
 <7948d79d8e8052c600a208142755b7a74b4aeee0.camel@redhat.com>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <7948d79d8e8052c600a208142755b7a74b4aeee0.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.

I'll update it in v3,and add send it in a new thread.


Thanks,
Kunwu

On 2023/11/21 20:11, Paolo Abeni wrote:
> This does not look like the correct fixes tag, sparse warning is
> preexistent. Likely 23aebdacb05dab9efdf22b9e0413491cbd5f128f
> 
> Please sent a new revision with the correct tag, thanks
