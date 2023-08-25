Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9462788E04
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbjHYRuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbjHYRt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:49:57 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD62213A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:49:55 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a88ff732aeso1052130b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=secureurbusiness-com.20221208.gappssmtp.com; s=20221208; t=1692985794; x=1693590594;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bVSFn/Ni8/9J575M/kUiPkLC+dJ//kzHEfRzZ65j7LU=;
        b=T3/32SN7DEwFAhoEhlkmR1NvVqFvlE+asY3Jorw/8hDB3yzecRYPhy6FL3WrIzuBpm
         r4dN5n2pjQni0XKYJzf6FqXOhzKb7DQ02xZTm7I57B25rwofTjnLh5oSzIM2faWLxQl6
         282X4EDmz7KRBAtsKhBAHxW/TmfO1KEdIzXgB9n0WIkJhDhT1WhKayT7Q058ZJORa7HL
         11X58J+acS9N6J18F3tOVKVGDu5mX1J7ozylULqfAy47rrxl9a6yDanXCA66uUW6X4bs
         GArpPZ5wNU21enimiq96Q7Px9rwVxVp5FEv+32Y+eCQ6eYwF66kGq5r0/UHm9SyGcw8p
         DLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692985794; x=1693590594;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVSFn/Ni8/9J575M/kUiPkLC+dJ//kzHEfRzZ65j7LU=;
        b=DHvS4mv2o2Lm19RjBUpag0alckcnPSshbG4dCsvjnurcOWmOvFFbZNs21YHaDYriSq
         r1nv5EnPcqxYUHm/yQeLu0mXS+r2yVwvp9YhV90vPRowhcxfFJUISAS+N+4sEFJjQVIl
         cfYHGLaP/a9ItgyLAjvq574DEh+T+1bEEv6SkgrOwSm5glhm+84NhwZ62uTV25GmFUlc
         FleQLQaBa3bZk+mTf5MnGIOQvzkTxYPQhMsp8udy12vl1pOiGtNJ7ldFbsad73PgMhf3
         oRL1H9xO4MF9gQRO83Xsa4bbA9l0Fjizc/AKt4be7lPxsXXewKWwiZSuLycoS0baaPLo
         tsTQ==
X-Gm-Message-State: AOJu0YyWwEJLgS2XWqeH5i40EGRiIVFw0BdF3QaTiatKFcmF40enEmpH
        72XTFJhu1W5JuDX4xVS1iee/7LME9RCMKFsevwp2RA==
X-Google-Smtp-Source: AGHT+IHLMEVYOeOa0sTNpg2L6EJhJaSfA2kzrvHklYk2xVJB54m+H6jU/EFN4y/bi/mZX35Y/BQZ2vvAAgAro9FhzKs=
X-Received: by 2002:a05:6808:23c4:b0:3a7:5eb7:e32 with SMTP id
 bq4-20020a05680823c400b003a75eb70e32mr2040389oib.13.1692985794727; Fri, 25
 Aug 2023 10:49:54 -0700 (PDT)
MIME-Version: 1.0
From:   Jessica Wunder <jessica.wunder@secureurbusiness.com>
Date:   Fri, 25 Aug 2023 12:49:42 -0500
Message-ID: <CAG_YDDE_6Mcrcm5KYbd9XKn4PGUG3zVa6d8Hah4E3B9asRv1tg@mail.gmail.com>
Subject: RE: PACK EXPO Attendees Databank-2023
To:     Jessica Wunder <jessica.wunder@secureurbusiness.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FILL_THIS_FORM,FILL_THIS_FORM_LONG,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring PACK EXPO Las Vegas Attendees
Data List 2023?

List contains: Company Name, Contact Name, First Name, Middle Name,
Last Name, Title, Address, Street, City, Zip code, State, Country,
Telephone, Email address and more,

No of Contacts:- 40,357
Cost: $ 1,926

Kind Regards,
Jessica Wunder
Marketing Coordinator
