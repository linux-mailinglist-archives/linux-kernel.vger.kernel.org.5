Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B31800E70
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379385AbjLAPTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379333AbjLAPTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:19:37 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D26103
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:19:44 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c2b7ec93bbso466318a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701443983; x=1702048783; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XORY2DBtlEuGBAs1NdUeMbodtZDAGCEM0LQbLOkkNw=;
        b=DnNggdjuqDB6FfEt7mOi0Sl+BfDDIYF+7fLVq1yEYZbv3pQcKnvoAZYMNReYXqEXr5
         dss6/F4Rfes0jGK7hoF7w6EAJbV+/qpC/fqc/2mSofxuFwtpsfvBSaD0f1tAA2muvyhV
         a52SGE0xUA45Lpgj/Uq/i+7E38nrJGV+rVnEn7Igi7Cjzf0YeaVKoG85VKCi2uK7c8EN
         DcVZiyAF7tSzUsfueq5ozldc/N3EiIqc5R4MH0sDrd8pEKGJZVySL7Sr4FnGMkHODxmN
         i6nxqdVDonL62yZOHUQm7m/RFzCCPs8coeNTPlLXerwbZkGWWeVlEZb7GREF7hCZ8gmq
         O7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443983; x=1702048783;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XORY2DBtlEuGBAs1NdUeMbodtZDAGCEM0LQbLOkkNw=;
        b=hOvhZbAly/H+oVOHbPMs6wVpmi7DtKb67ICKl60mjTZiUL8VbPIg9cCpIktm1qNUJ1
         7fPbAE70GlA79eYkp4TvhCuR+43U90fOD3tOw8O5EQqEL0iSR8PqQRYmFOLfpJ3Wojbq
         eX4DYZwwIR1Zxtd5PdtG0jAFkmamPGEsJth0/khq43QXFQtAGE8rCT5d6oiV+rqfR+4+
         TuEKQoZ+kM65ipyUPE2CBKO8AK64R8oZdgpFgv5A2kK8MnNVpv9hTaxi2mhY5DjKXOrZ
         u9AWPGbVi+tFuC2X93xITI7fC0U2dBnFwzw2BIuXg6XyKJYUTeycuUE7Z91TWNQ3iVvH
         ZTTA==
X-Gm-Message-State: AOJu0YxbQg+2B7uJ5wYwwpMpPTg1Grsz0DLwaOgsdOxCsHcYLtw9lg9D
        7dJ+LAkAyAzxSoeMq7MbnExw0m/H/0HaVDK24ck=
X-Google-Smtp-Source: AGHT+IFJ+JRIV4kCeXY3m7xFZ5u/OK3bf1KgxOARpApVfqa3CKQo8oXFc9bl3z3tyDP7ZO3WtxiGgIUv7gPUsmodFmA=
X-Received: by 2002:a17:90b:4f4a:b0:285:a189:cc6c with SMTP id
 pj10-20020a17090b4f4a00b00285a189cc6cmr23825283pjb.5.1701443983464; Fri, 01
 Dec 2023 07:19:43 -0800 (PST)
MIME-Version: 1.0
Reply-To: mr10james.smitth@gmail.com
From:   MR JAMES SMITH <mr01jame.ssmith@gmail.com>
Date:   Fri, 1 Dec 2023 16:19:30 +0100
Message-ID: <CAKto=8GTK7nPfSzNJ=zVSm2jPYoQ9J9JQwuUJYxBcwhh4QANCA@mail.gmail.com>
Subject: Confirmation of funds received
To:     MR JAMES SMITH <mr01jame.ssmith@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,MONEY_NOHTML,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:52c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4993]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mr01jame.ssmith[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.6 MONEY_NOHTML Lots of money in plain text
        *  1.3 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI
I am writing to confirm if you received my previous email regarding
the unclimbed funds of( $10.5m) Owned by a late client Mr  IGOR

Regards,
Barr James..
