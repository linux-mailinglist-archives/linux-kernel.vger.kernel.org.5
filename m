Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7850F7E8999
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 08:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjKKHOy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 11 Nov 2023 02:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKKHOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 02:14:53 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1971716
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 23:14:49 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so3018457a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 23:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699686889; x=1700291689;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZXPgZsRDhHVKtTCIzWfu9JbsH4viWkWG1onDBkCkdI=;
        b=vqb+fRol9hzVyytNR4awxHj7yiR6bUqFRBn0YsWHw7nSWXugUUIqPe38iMgdiaGe90
         ugnSCHRHlRLIedS20EcqlF1ByBUYtrcV1JWhnStUQGWzdFI9PSawqlabbiNN/ParNvfR
         38KJvait3w4GOJQsTVy00w+mG9oq0VQJE8g2UcK01Bdv0Z6DjLSUzAKSRNYz4QUwkGz7
         L5hFH496QPcriGdjw7erBGqQqGATy8PFSydL+TqIqfP9ZG2CB+zq0/b2fBpGi9x6Jw2O
         oermVxXbrrf8KqvmrEbKwi+LlngHao0mHwUdxq4z9OkooY0wFJw1Lh/lEnzxsQMbxzPa
         E4QA==
X-Gm-Message-State: AOJu0YyTqWzImO4hNxttv2L2c+BbpnoPDz7nP6PxzmTvtc9dbDaPjM3q
        Di1G3KbPpDkhI3y7U/7MGii75zg/BEaA0W5VBIMq7Vk9XVX5GAk=
X-Google-Smtp-Source: AGHT+IH3t3D+8sjEvek3gxpVoiYOBAvahxY00a9tMLP2QfAADfKQ3QaGCTjPlGe8Kh73vD28hLcfzY+khNvPuZRN9lQh+G9yXUt6
MIME-Version: 1.0
X-Received: by 2002:a63:b10:0:b0:5be:9b7:23ed with SMTP id 16-20020a630b10000000b005be09b723edmr350283pgl.3.1699686889081;
 Fri, 10 Nov 2023 23:14:49 -0800 (PST)
Date:   Fri, 10 Nov 2023 23:14:48 -0800
In-Reply-To: <000000000000e32603060314b623@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040d40a0609db3136@google.com>
Subject: Re: [syzbot] syz-test
From:   syzbot <syzbot+cb729843d0f42a5c1a50@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: syz-test
Author: jose.pekkarinen@foxhound.fi


#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
5a6a09e97199d6600d31383055f9d43fbbcbe86f

     José Pekkarinen.
