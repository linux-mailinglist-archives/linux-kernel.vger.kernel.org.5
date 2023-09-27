Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D29D7AF81F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 04:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjI0Cak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 22:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjI0C1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:27:08 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B74849F5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 18:56:14 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RwKTP5TMPz8XrRH;
        Wed, 27 Sep 2023 09:56:09 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
        by mse-fl2.zte.com.cn with SMTP id 38R1u0tg042509;
        Wed, 27 Sep 2023 09:56:00 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 27 Sep 2023 09:56:01 +0800 (CST)
Date:   Wed, 27 Sep 2023 09:56:01 +0800 (CST)
X-Zmail-TransId: 2b0665138bb1ffffffff8bd-2abae
X-Mailer: Zmail v1.0
Message-ID: <202309270956011542404@zte.com.cn>
In-Reply-To: <CAJuCfpG2aEv50KFWu4m8isg9dDWQxY9uCGhm=Y0N0AaqPHir8Q@mail.gmail.com>
References: 202309141353492446199@zte.com.cn,202309141710195376952@zte.com.cn,CAJuCfpG2aEv50KFWu4m8isg9dDWQxY9uCGhm=Y0N0AaqPHir8Q@mail.gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <surenb@google.com>
Cc:     <hannes@cmpxchg.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <surenb@google.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBzY2hlZC9wc2k6IEF2b2lkIHVwZGF0ZSB0cmlnZ2VycyBhbmQgcnRwb2xsX3RvdGFsIHdoZW4gaXQgaXMgdW5uZWNlc3Nhcnk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 38R1u0tg042509
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65138BB9.000/4RwKTP5TMPz8XrRH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, I know I owe a review here. I'll try to review it by the end of
> this week.

Never mind, always appreciate your reviewing. Hope don't disturb your
weekend rest.
