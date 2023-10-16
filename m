Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78A17CA895
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjJPMzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjJPMzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:55:41 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CF1AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:55:39 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-49d39f07066so1863620e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697460938; x=1698065738; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZsXJhbyRWj1Yc4fVVW5n6XxL9CVRx7/R8IuFKBYjV4=;
        b=hsxzsDK72kR+YETJK5uhfXGmjfMPM9ni4GBz5E+zDx/RTG+dSk8+3eYeU/OFU69UuF
         9fE8jndlvFkS181ivHB2S7I4NfjnihiTcCr+CKc9mCXSCUQibhILffLlNGyXfDZwo1BY
         kBg9jCiKpoZm9/HncLAEyidXD8cQtq6HyDWf9r9hIdjY0bDHuSio1jztBTfFIHxb5Zm5
         NrGkJEW/Dunnq+0FkawmjRrQp+4z64+0qFhcqojHjJXXlLaZU9HAwpcCtYi0cz/vkcij
         0FkvLHDmroeMADwrNH+peMKuKiVfjkS8RbN94dOEmXb09pruLeUpHuZCETyQqt6J6VMi
         7nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697460938; x=1698065738;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZsXJhbyRWj1Yc4fVVW5n6XxL9CVRx7/R8IuFKBYjV4=;
        b=SlEpd5hwL57YB5z5glspXhVGjd0I2zRrbpvJTCQ65LSC+DTO0xRdgGWCeeWsm/a6UC
         LUcnhC0fIsPZQkzxYbIAYu5QCXWldXvle14jh0Wlesufv4HnKpenqj1Z4ARBHVII0H/u
         6mMzdvo7tv1leGgg79awJPR7pKcnm/By9qLAET9KXNEFyAMAeosF8RhsxCZp21spFngW
         o8A5iG1BXmRY6I/6fFArDVPP3VuzPCoghTEuJQXrMYctL8pPBZamGJpjSFGBaoTMQAdw
         UMNRr5yNk5LIL/+3N4tlS9woYNpMNH8+F6i2kaUiVNF4bCs5b54/3E7+XAIshkVPtAXV
         P7tQ==
X-Gm-Message-State: AOJu0YyvuyY+2LDGgooFeXiH/bQM483uOgMN8H9tNIspGdiFE9MsXvY0
        Zb1LmdpX/XRd7iL/n7WtbAT7bEZn8VtlKigYtVw=
X-Google-Smtp-Source: AGHT+IEKEmA/xANRwpTTj72E0SCd4X+z5ArVbZpT6DxNEdbqYFrnjE9ivIDbOL2miFdb7vUeFWG+6Dhz6PINZBwFjO8=
X-Received: by 2002:a1f:e3c4:0:b0:49d:10ce:9a8b with SMTP id
 a187-20020a1fe3c4000000b0049d10ce9a8bmr23265359vkh.15.1697460938351; Mon, 16
 Oct 2023 05:55:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:af58:0:b0:3ea:1756:3780 with HTTP; Mon, 16 Oct 2023
 05:55:38 -0700 (PDT)
Reply-To: siennaarchie22@gmail.com
From:   Sienna <zealingzealing@gmail.com>
Date:   Mon, 16 Oct 2023 12:55:38 +0000
Message-ID: <CAPv-racpJTW5z8GkrWcvcwt9DqUA+uBCKZk56OCS3YfWXRf8rA@mail.gmail.com>
Subject: I'm Mrs.Sienna, I want to hand over a charity project into your care,
 kindly reply,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm Mrs.Sienna, I want to hand over a charity project into your care,
kindly reply,
