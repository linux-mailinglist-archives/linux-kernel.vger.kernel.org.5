Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA9176277B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjGYXlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGYXlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:41:52 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3632B1FDD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:41:51 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-563db371f05so408886a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690328510; x=1690933310;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWcC6NZnwplKxnJubHdIw6W1xXpN9D0rWOANNHWmQz4=;
        b=4QoIsgD0aKg8cm7D42eqOcaczpv+G18YfoUra8P5i9LdEAb4sPivfVku7GILRprbbn
         876cPLdUSl+t4WX66PhvT9iozT/Y/zPI8TUxxbrS0qPqew4Ws3XF2/D6p0hOPa2AH+If
         yztZ4H5r0HUHmzjuAhea6YhAgFzQmxLc7veIzn7nu3NnrH+wzpEbRL93XXs4LfqLShM4
         q/kAXlzY52E1yg8s32d7kbHzVDtsSUp96nq4QDLa2xkcxq8oGPNgLui7lYD4BYqhWHUs
         u1K8vywP6SK/80LYzu1X/hAXxa2QpWcBTau5IffV458XfYn3Xk4MsZ+zDbylKSBhG018
         kcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690328510; x=1690933310;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWcC6NZnwplKxnJubHdIw6W1xXpN9D0rWOANNHWmQz4=;
        b=B9y+FucnFQJTC4aI8E2TmvwbQ/2hjKl1nhr8zfeStcE1hYv6DIYLy5SfzP111JId23
         VnbMjuifvOJCtdU4dqke+od4pqEMPlV4HlkyEbhneEZkzvzHO/OHCmP/QcV+Dw52SD5T
         96j4+xR7fSk7wl1fWIUPefzDYedbk1WSvftADEfVuZsemvwx8ZGPXp69RI4TiO1GVRfc
         b6SiE7yJ307hpSSg2QrNm87QPLZCC1qOPUPqsC+/odK/BgxLATvQsb/jpUP+JMOG+t0A
         77zolYhX3sizhRjgpqR1daRkoS6sS9EHIM/wiTLmrdDebmZLhypx+tJxmOFEKvD+H1sc
         HXiQ==
X-Gm-Message-State: ABy/qLZ79+zxAPlRT5LmmThG/GjkiN/vGmU7GcG7JEsndajIDiSqfIig
        lzMlND+lyBjNlH0vom1yfoO65bNokRE=
X-Google-Smtp-Source: APBJJlEfUJLdUrmrbSlFBFGHSdTPzHYSaXbojZzRQq0Qqk2F9CvFkeKhfcnsFT29n4IYiT0HAeKLuEt5S3o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:7411:0:b0:563:4869:f54d with SMTP id
 p17-20020a637411000000b005634869f54dmr2530pgc.11.1690328510698; Tue, 25 Jul
 2023 16:41:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 25 Jul 2023 16:41:45 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725234145.351635-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2023.07.19 - No topic
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No topic for tomorrow.  I'll log on in case anyone wants to have an informal
dicsussion about something.

Date:  2023.07.26 (July 26th)
Time:  6am PDT
Video: https://meet.google.com/vdb-aeqo-knk
Phone: https://tel.meet/vdb-aeqo-knk?pin=3003112178656

Calendar: https://calendar.google.com/calendar/u/0?cid=Y182MWE1YjFmNjQ0NzM5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986SngGlhPH?resourcekey=0-FDy0ykM3RerZedI8R-zj4A&usp=drive_link

Future Schedule:
August 2nd  - Available
August 9th  - Available
August 16th - Available
