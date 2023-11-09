Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234627E69D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjKILml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjKILmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:42:39 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895252D73
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:42:37 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so1161964a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 03:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699530156; x=1700134956; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25lTnoE066OaEp+8cH+Y4l00S7glQWqDX2qC7CNByo0=;
        b=AivI8KvpeuXVpL5MwjFLVIbGuQejWpNuZhqcroI0cV0Wv0tiBvBJLY1DXLrxjrl2Ic
         rpsoyjC6QJ0YVKKB6en1LxEMqt/ZHaHRqn6wuboJCdrXVtZCCovzVqHvkw/VUu9bbtrh
         HAnYDxFH9RdE0W2bZA9U7wmKoTbISJH4aMRDs6wPqLKPLTPUGzTHc4RPaz6nFQQvWW5m
         mvTRmC643Rx7rsqVQD36Hj86yCeU9INBizGRqFQfmbiQKhuO7ICgC967NRtE38fICFcT
         jfaOAopBldcBLYqP6Xje7dcUz3iHfIPNQXbtlehnJFmni/ScJin5E4atBCrAas7gDzfe
         WEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699530156; x=1700134956;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25lTnoE066OaEp+8cH+Y4l00S7glQWqDX2qC7CNByo0=;
        b=QkEEX6EUX0gZqGkmPUvyVCAY2Pu6XkMqrdN8Oe3xWPrXd1XetkefuVnLn1LNArFu8N
         9VoRkL5Y1ZuvtnAXggWTOtm7XT6WGkW8dO11E2yJ9Ahas54lMUfIgtOX5tmcJyPCZzHN
         GHL/AsFGOhdELVSVolCBOybEn9V3+iqQ8uvRT6I4mEvgQV5ikmKif5T/bghwoiXPJYDH
         aQ9Ig0cvtmGvOUtc76lro/PGCn4+SF2ZaeBTpeWRy4xvTHtvO9bg2FXqPkyqepotzrz4
         I5023pDwhawUr7aqECFCQbsyL+DSua6oArwJqyb4uOJZYAHEqJkK4nywKtBCCbhUKiqx
         96hw==
X-Gm-Message-State: AOJu0YyWSh/M3WeNqM2U9LB8Yrb4hZNRFCkLNiH9lawAeDPknm8nv7dp
        beMQr/QtGVeYdhC0+lyxzwqI4aHWk35RGnlJduQ=
X-Google-Smtp-Source: AGHT+IFbGUJP9UPSlcvvKvHIqz/Qn4VTq2Epb4SzJ3xYrg/JbCeg988ryuUlEM+OPnayZXURDAmamgdVq8pbfz5YASo=
X-Received: by 2002:a50:cc95:0:b0:543:5568:8dce with SMTP id
 q21-20020a50cc95000000b0054355688dcemr4537968edi.30.1699530155751; Thu, 09
 Nov 2023 03:42:35 -0800 (PST)
MIME-Version: 1.0
Sender: gd904663@gmail.com
Received: by 2002:a05:6f02:834e:b0:5b:e3de:3de6 with HTTP; Thu, 9 Nov 2023
 03:42:35 -0800 (PST)
From:   "Mrs.Eileen Klaassen" <mrseileenklaassen44@gmail.com>
Date:   Thu, 9 Nov 2023 12:42:35 +0100
X-Google-Sender-Auth: B1U3Q-B6Qdq22Lx4eDG68vWGdAk
Message-ID: <CALcWyrLF0wXuFpVoFSD=-t5oM3mrZRMgANo5HZRvB0mbR_ZcoQ@mail.gmail.com>
Subject: Hello, Dearest
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dearest Friend

I am MRS. EILEEN KLAASSEN, I have decided to donate what I have
to you/Churches/ Motherless babies/Less privileged/Widows' because I
have been suffering from throat cancer for two years now and I have a
short life to leave according to my doctor, I am entrusting this
charity project to you, I do not have formal relationship with you but
because of my present predicament and circumstances I am, I made to
contact you.

I have made up my mind to donate my inheritance of $8.5million to the
less p rivileged please help me to fulfill my last wish. At the
Moment cannot take any telephone calls right now due to the fact that
I am unable to talk due to my health status. I have adjusted my will
and my lawyer is aware.

I have willed those properties to you by quoting my Personal File
Routing and Account Information. And I have also notified the bank
that I am willing that properties to you for a good, effective and
prudent work. I know I don't know you but I have been directed to do
this by God. I will be going in for a surgery soon and I want to make
sure that I make this donation before undergoing this surgery.

I will need your support to make this dream come through, could you
let me know your interest to enable me give you further information? I
hereby advice to contact me by this email address
(mrseileenklaassen44@gmail.com)

Yours Faithfully,
MRS. EILEEN KLAASSEN.
