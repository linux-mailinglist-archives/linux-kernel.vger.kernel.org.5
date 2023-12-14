Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2743F812ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjLNI5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLNI5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:57:00 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118B510A;
        Thu, 14 Dec 2023 00:57:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyTuMXi_1702544220;
Received: from 30.221.148.227(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VyTuMXi_1702544220)
          by smtp.aliyun-inc.com;
          Thu, 14 Dec 2023 16:57:02 +0800
Message-ID: <e6d9b59f-9c98-53a1-4947-720095e0c37e@linux.alibaba.com>
Date:   Thu, 14 Dec 2023 16:56:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC nf-next 1/2] netfilter: bpf: support prog update
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        coreteam@netfilter.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
 <1702467945-38866-2-git-send-email-alibuda@linux.alibaba.com>
 <20231213222415.GA13818@breakpoint.cc>
 <0e94149a-05f1-3f98-3f75-ca74f364a45b@linux.alibaba.com>
 <CAADnVQJx7j_kB6PVJN7cwGn5ETjcSs2Y0SuBS0+9qJRFpMNv-w@mail.gmail.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <CAADnVQJx7j_kB6PVJN7cwGn5ETjcSs2Y0SuBS0+9qJRFpMNv-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 1:50 PM, Alexei Starovoitov wrote:
> On Wed, Dec 13, 2023 at 9:31 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
>> I will address those issues you mentioned in the next version.
> Don't. There is no need for the next version.
> None of these changes are necessary.

Can I know the reason ?  Updating prog for active link is kind of 
important feature
for real application..

Best wishes,
D. Wythe
