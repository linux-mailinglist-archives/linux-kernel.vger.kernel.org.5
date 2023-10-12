Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968827C6290
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjJLCNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbjJLCNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:13:21 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D0298
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:13:19 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S5Y8B4rnFz8XrRD;
        Thu, 12 Oct 2023 10:13:14 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl2.zte.com.cn with SMTP id 39C2DAmG087624;
        Thu, 12 Oct 2023 10:13:10 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 12 Oct 2023 10:13:11 +0800 (CST)
Date:   Thu, 12 Oct 2023 10:13:11 +0800 (CST)
X-Zmail-TransId: 2b06652756372d0-e8701
X-Mailer: Zmail v1.0
Message-ID: <202310121013117557422@zte.com.cn>
In-Reply-To: <ZScQZLTssSfq19Jm@gmail.com>
References: ZST/WggW4hSVs9d4@gmail.com,202310101641075436843@zte.com.cn,ZScQZLTssSfq19Jm@gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <mingo@kernel.org>
Cc:     <surenb@google.com>, <peterz@infradead.org>, <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <mingo@redhat.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IHYzIDIvNF0gc2NoZWQvcHNpOiBBdm9pZCB1cGRhdGUgdHJpZ2dlcnMgYW5kIHJ0cG9sbF90b3RhbCB3aGVuIGl0IGlzIHVubmVjZXNzYXJ5?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 39C2DAmG087624
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6527563A.000/4S5Y8B4rnFz8XrRD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, so I believe we may have been talking past each other for past 
> versions of this patch: why is this patch modifying the order of the 
> modification to group->rtpoll_next_update?

Yes it is, I may not have fully expressed the reasons clearly before.

> I rewrote the changelogs for readability.

Much grateful for your guidance and work. Learned a lot.
