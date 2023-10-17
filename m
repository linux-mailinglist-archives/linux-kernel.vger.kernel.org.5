Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A04D7CBD62
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjJQI31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJQI3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:29:25 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C13DB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:29:19 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49e15724283so1886550e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alu-bue-edu-ar.20230601.gappssmtp.com; s=20230601; t=1697531359; x=1698136159; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6mkNt3pD1WxeRdOfoMTKS70mKcT+7mzzVQHpG9fxnk=;
        b=DwMHiq0/w1W8xS5Q/LFBC+AVDwSWw4/ARBnUwrKBT6bG2vq+flIWmFmSRPsLP9M8au
         t7afRRf0w5omqrQ+W7bWGk4LAA8RIGpzhskOiQiv0+ZhEwO6XdRY5AfOH2JkJakTGBAP
         5W7gso4BCIDnNF1dVfyKzAZUPQWXopNKqppnJFV5Ecs9NqJ+1U3FcS6UZ4lHNwoiwxvy
         aSIdh/lkFDv9ZjF1ewzvqy/+7Jkpgb27WZ/oF9WdD86LhsRu8XPQUy9CiKpojgVyUGHz
         oneFwH6ynhEmqNPtpV4JVQtXsZIBot7GlBnb7boEekmJHbJ9PiEuo4Ev3VYJpIyyoKgD
         Tr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697531359; x=1698136159;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6mkNt3pD1WxeRdOfoMTKS70mKcT+7mzzVQHpG9fxnk=;
        b=mfTmNOwg3GusDbSuRKy+gPe1vSW8mnjvNH9tLaRcfO74yeSO8V52T6djrTpR4IHYC1
         1DSH5yXKnAokom7Wm4CorZWqfsf94YOOBMnZ4PWyiCn6vLv9x7K45z23VrzbM2Fgsw2+
         7aFafmd4kX3YciQiQcjHr5Dv5auSXfwQN8EjfVWBn2zbsHRYty9+tFSuYbMg8xVi1WJH
         xkDJquT+8cw464XWv+K6efqp8k7Ir/zBVi1l+ebXiwrdF220UtQvRNtvBWpaZqwqvYq8
         jCFLjYYVgxzwe7FhVknGg+wib+bsJ3bgLsZOFaeyp8S65NxUnZ8adQqpCM9Rx7+uQBQ1
         HXWw==
X-Gm-Message-State: AOJu0YxBEvpS9fF9swg9YebMTKm5Gvvusi35YBBUnZoW9AXVkHWCFp4v
        PoVaA48zfsx7tjgYJVSmr29Fm4WpWU/RYn1j6aIsSQ==
X-Google-Smtp-Source: AGHT+IGx0po7ANcXrMu0nrdtKIlURCO2wnr5YENJH3T/LNH39a9qOouxRQBK1ZMD7gquVxXqlfnZjF6qnZQF+Oile5o=
X-Received: by 2002:a1f:2f16:0:b0:499:e671:1682 with SMTP id
 v22-20020a1f2f16000000b00499e6711682mr1618818vkv.3.1697531358754; Tue, 17 Oct
 2023 01:29:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:a8ed:0:b0:3ed:85cc:b0dd with HTTP; Tue, 17 Oct 2023
 01:29:18 -0700 (PDT)
Reply-To: miss.mercyadams2022@gmail.com
From:   Miss Mercy Adams <sofiac630@alu.bue.edu.ar>
Date:   Tue, 17 Oct 2023 21:29:18 +1300
Message-ID: <CAF+fmkP-qqNJg_0ftvdGiQGP19j7jVy8ST7aD+KyCY-LLNDMEA@mail.gmail.com>
Subject: Betterment of my life,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HK_NAME_MR_MRS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:a34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_SPF_TEMPERROR SPF: test of record failed (temperror)
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [miss.mercyadams2022[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.0 HK_NAME_MR_MRS No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please Can I confide in you?  I Am Miss Mercy Adams, I need your
assistance to help me to invest my inheritance fund in your country
and to help me to come over to your country for the betterment of my
life and continue my education. I will be happy to hear from you, and
then I will give you more details.
Best Regards,
Miss Mercy Adams
