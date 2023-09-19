Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D6C7A6A38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjISRw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjISRwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:52:55 -0400
X-Greylist: delayed 2574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 10:52:49 PDT
Received: from wp441.webpack.hosteurope.de (wp441.webpack.hosteurope.de [80.237.133.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF8592;
        Tue, 19 Sep 2023 10:52:49 -0700 (PDT)
Received: from [2a03:7846:b79f:101:21c:c4ff:fe1f:fd93] (helo=valdese.nms.ulrich-teichert.org); authenticated
        by wp441.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qieEF-0002Of-1O; Tue, 19 Sep 2023 19:09:39 +0200
Received: from valdese.nms.ulrich-teichert.org (localhost [127.0.0.1])
        by valdese.nms.ulrich-teichert.org (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPS id 38JH9cRR007304
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 19:09:38 +0200
Received: (from ut@localhost)
        by valdese.nms.ulrich-teichert.org (8.15.2/8.15.2/Submit) id 38JH9ac1007303;
        Tue, 19 Sep 2023 19:09:36 +0200
Message-Id: <202309191709.38JH9ac1007303@valdese.nms.ulrich-teichert.org>
Subject: Re: Arches that don't support PREEMPT
To:     hpa@zytor.com (H. Peter Anvin)
Date:   Tue, 19 Sep 2023 19:09:36 +0200 (CEST)
Cc:     tglx@linutronix.de (Thomas Gleixner),
        glaubitz@physik.fu-berlin.de (John Paul Adrian Glaubitz),
        peterz@infradead.org (Peter Zijlstra),
        willy@infradead.org (Matthew Wilcox),
        torvalds@linux-foundation.org (Linus Torvalds),
        ankur.a.arora@oracle.com (Ankur Arora),
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
        geert@linux-m68k.org (Geert Uytterhoeven),
        linux-m68k@vger.kernel.org, richard@nod.at (Richard Weinberger),
        anton.ivanov@cambridgegreys.com (Anton Ivanov),
        johannes@sipsolutions.net (Johannes Berg),
        linux-um@lists.infradead.org, bcain@quicinc.com (Brian Cain),
        linux-hexagon@vger.kernel.org,
        richard.henderson@linaro.org (Richard Henderson),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        mattst88@gmail.com (Matt Turner), linux-alpha@vger.kernel.org
In-Reply-To: <7EB81196-3A32-4638-A076-0C0CFF722996@zytor.com>
From:   Ulrich Teichert <krypton@ulrich-teichert.org>
X-Mailer: ELM [version 2.5 PL8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;ut@ulrich-teichert.org;1695145970;e28d9866;
X-HE-SMSGID: 1qieEF-0002Of-1O
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[del]
> Does *anyone* actually run Alpha at this point?

Yes, at least I'm still trying to keep my boxes running from time to time,

CU,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de | Listening to:
Stormweg 24               |The Baboon Show: Rolling, The Chats: 6L GTR,Plosivs:
24539 Neumuenster, Germany|Hit the Breaks, Nightwatchers: On a Mission
