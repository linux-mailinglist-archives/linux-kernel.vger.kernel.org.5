Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6646F7977EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbjIGQhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbjIGQgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:36:49 -0400
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C115592
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:50:43 -0700 (PDT)
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-6c07e122a78so756303a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694101726; x=1694706526; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vRPcksPfr/wMolNdMbpuXmYrrtQ/1MWuNBmFMzfZbJM=;
        b=pIta63YFximbrQF3PCLe+GL7NUre2eMRXWCTD3INjNMw5HtdpUQ1IYASLjK/7WkHdS
         Up8IWfRzfU5E3u8YhW4tEJL0xnAkxR/cvd6L84sGmzA/5lz0YZtvfZ+62ZSVataW3ow5
         fFmGqgYpN4L34vNkxYOfsJy4i5xnur+yi9fOoaqO5ay9wd/mFs+o1vimgIdIUwbrSA04
         W4O5Mv1xvHZ+SGHvWxv5EvSE4eBbulQQYro3uWORmwnA/b/FqJo3UhNIWV/hOPdjdZDR
         k7AUyk496XJlvCNjIM3lP6yB3bR4YDsrc40MpuLVm/4VFj9sttzylkV+/7WKEmTHxATF
         X6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101726; x=1694706526;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRPcksPfr/wMolNdMbpuXmYrrtQ/1MWuNBmFMzfZbJM=;
        b=BTrE1OyqUGkj6SLSX8UZI2yhi0Mp22I9Y0iUy12RhpoSka97RAqgoqONaqJRivQGDp
         ioKR4zd8H2fzcl3bq1RNHmn5xQFKKuizJF6ndJzutPQ7Cm6V6OUt06r0FitW5V46RqI9
         lKeO8TqLIwt3qPwMl5uRym56GPwHg7KERnEZKh3a2ANXFQJ//PrRbk8ZmMOeUFKqCl2q
         kHHjVNY+I47ISSRJLGvpcwSy3KFHD8B7fR5YbNDj8lE/sdkis0OjKMFav2dBYobOUr6t
         nNkbaHukuJso25hYBNBaXJxp2cyijhBSyD0JmPw6/JAhiaWtz+fm/l/EfhQUrUkGl7Aq
         t9Kg==
X-Gm-Message-State: AOJu0Yz7YGcSgYA47H1lsJg2DddF8PPfNP8vfwUMaHu49uK89DAIvUWA
        wKyitkWqLBH9WVnbqV1cEGqeqOw1I5SFYQsOKS7dBVy1HbU6me/U
X-Google-Smtp-Source: AGHT+IEEpuz+QaSueb6W1ezsZj35Kjks6cGyp0y2OYR4Qv+ye4BPYBxKrb3dAFCHmhFyZHzTnUUHusOjCyWGTQGxg0k=
X-Received: by 2002:a05:6e02:11a1:b0:34f:1fee:496d with SMTP id
 1-20020a056e0211a100b0034f1fee496dmr8801353ilj.19.1694087941866; Thu, 07 Sep
 2023 04:59:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:3dc7:b0:4e4:c7fd:e11 with HTTP; Thu, 7 Sep 2023
 04:59:01 -0700 (PDT)
From:   Olga Jean-Louis <jeanlouisolga898@gmail.com>
Date:   Thu, 7 Sep 2023 11:59:01 +0000
Message-ID: <CA+B-FkbDhmkZ79-E+7rG8oM71-fBfeOrkoQ-D-ni6_TqVuJcQA@mail.gmail.com>
Subject: Hello, I Am Miss. Olga Jean-Louis.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearest,
Good day,
Please can I trust you? to assist me to invest my inheritance fund in
your country? and to help me to come over to your country for the
betterment of my life and continue my education. Please Can you help
me?
Best regards,
Miss. Olga Jean-Louis.
