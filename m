Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70687E227C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjKFMzt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 07:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjKFMzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:55:46 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082E7A9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:55:44 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b2f43c4853so7149064b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 04:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699275343; x=1699880143;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHEdJ0gGsG1q8SSARui8BOQAq2b380ChLi6YY6e14SE=;
        b=ZiXnyxFswqxs1U3yvpLrOgC95hWpv91krB0bkrt3hUTEMakurNF130r5kVYoYa5BXx
         B/dFZs5XmnnQTp37QIkI90c+2s0GM8y4rccl1bx3P4jEbSYGhRlhTp5g5Y9Ljc2iWwd6
         hoauBaZfiHk6RMKGkBv9GZGwsaxGLgIBM2OZezJJZpsPu8+7iFrCOzsjd988DpMVyPrm
         WSpNuyunY/QUPlzhu3H8BCeWeU4zYXsUG/1ZGy9TxrWHPk1H2yC7OScOJ8iq6EjYExri
         uqDrX5TYksDh7Rf0FvgZ6qQWb3HHwM3HnMCnD3VPd9olHnltUCK4f9uAM0yVMeDJ4fvZ
         6j5A==
X-Gm-Message-State: AOJu0YxuqHJuhC8iPl8T8qkrcF4IYLK0bMCv8OnHRB8Dd90LzQoxcdEl
        onm5ik4fw6FJ/s0wU4Q3A7oR0KerC5cW4zvf1WhicfJr3ITn
X-Google-Smtp-Source: AGHT+IEpyqeL5uSVREdxf3fnpizaWb2cmBHT2+7Y0Jh0z6fAiqbB4/utyz0dAeNibXs6TaO6FnTuKPyguVx0prcDq2oLwpkUOMk1
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4198:b0:397:f54a:22d6 with SMTP id
 dj24-20020a056808419800b00397f54a22d6mr9694834oib.9.1699275343453; Mon, 06
 Nov 2023 04:55:43 -0800 (PST)
Date:   Mon, 06 Nov 2023 04:55:43 -0800
In-Reply-To: <DB3PR10MB6835AF75D60D9A96465F35C2E8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038e90506097b5ffe@google.com>
Subject: Re: 
From:   syzbot <syzbot+f0908ddc8b64b86e81f2@syzkaller.appspotmail.com>
To:     yuran.pereira@hotmail.com
Cc:     yuran.pereira@hotmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git�master

want either no args or 2 args (repo, branch), got 1

