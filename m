Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD627B16BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjI1I5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjI1I5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:57:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C1A195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:57:43 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c12fc235fbso146940871fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695891462; x=1696496262; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=Ce6U/Ezms7Vv5nwA9ACyshh7wgo/FvwsrrIvZW39sczrcpnvGCA7Ajq0I3Bk1BB4JX
         jkC9sTmy9LlvUTMiLgS2nSwPl+8FROMJD6VDDCHq996b8eXNpq8cpSjpxAYoJEB6RFwk
         EJiWouxdJIX4ZK5HzvpgykVgyySyN32Pv3pDD+rJZkibl7oxO2KkoJrgP66wR0OeU53E
         H/wzNHl+QOIy1uY0kcwxhkyg1S+zWXVpA1ZYa2oFio8dqKAvmhbaRzI2PzhILulUzTyV
         948XaFrL08swktous3n9wMqtY3gXEHy3kd2QlyYy1AAXzaeeKnsfQkuMcAQZdD6fkMLJ
         nxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695891462; x=1696496262;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=FXkrDdBUsCToBmDHZ/AIuFOeuQCObMR8fhYgA0xXtGG/6IgGOoI2K7tI03gC4lF3T8
         ZPjxvmt7dWfMnD60sf47ntoOoabYLvHZVJTD6OFwTH2TtP5txXjuhIecHSmfKybcOYO6
         68PJ9Y+MvVD6ARpHyyVjJvyK6G1CRNHHlgQfHCmvshLYQPI+CVQSNuc8jzk9IBN/WsOc
         FC7J7P5r+nEuA1gWooOiWYshxhCac1zEXeAGYBUhiX604452rnMi8zf+Z5PNTeMh4GFE
         bPHIz1oOagiN3RroCC+xVebiAlNuUl93E0W7nOVMncM7RNjRlXsLsBjTTyVZnheetmsw
         x6Eg==
X-Gm-Message-State: AOJu0YzTU5AFpIUgvFJaVqs4EclnK7UNtC9Q1lSTHTuhNy4ruAJjfud+
        OBhZKEFILB3SvEAfzIHIUqNV4JVOjPrqOYkSAg==
X-Google-Smtp-Source: AGHT+IHyze81EQ0oMo1k2+NlgK8HqSYLS/+8IOdRr28Vio3xocnrseNHKHI2YgfoPfbsqSWHPKUefHVOFY0xOq65bIc=
X-Received: by 2002:a2e:a28d:0:b0:2bd:1f0d:8c07 with SMTP id
 k13-20020a2ea28d000000b002bd1f0d8c07mr337254lja.19.1695891461672; Thu, 28 Sep
 2023 01:57:41 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsanna62@gmail.com
Received: by 2002:ab3:7152:0:b0:23c:a3cc:3d5a with HTTP; Thu, 28 Sep 2023
 01:57:40 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Thu, 28 Sep 2023 01:57:40 -0700
X-Google-Sender-Auth: yhCmn7KGTHVaBtO1QGRqUIejq8Y
Message-ID: <CABLa-dpapGc9MTeJ0W0yTkbbzeT4+D5vYwOLzFwGO0fE_NWzCg@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
