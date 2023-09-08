Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96864799161
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243167AbjIHVHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIHVHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:07:19 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA11FD5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 14:07:14 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3ab29af398aso1760150b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fortunewebnetworks-com.20230601.gappssmtp.com; s=20230601; t=1694207233; x=1694812033; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lWSOOTCDXcWLt+hpkQtfiADbPF+nA5H+PcCI5nxKBLM=;
        b=DW1ex57TjJQS7gzdco/bXTEIu/cax0emVLApR88mXcQCZF+JJFM9OaUSBO4Re/tu6i
         hu9m9ghb3geFAQ84Xh0uqE/gaj50qXXAH8zxYwTkxENoofW7wmdHJhYqu+9hM32Rb8U+
         ItiB74T0/3qSzaUTlYn4V6aPgGsWOfjP/Az1J2WyCa+yX4ivW1eycgeJcRhGakVvznSH
         Uhq1jK3KGL9nmHzgCwPghA66ECBzKLga6qY5S3it7DXnb9qsedlG3FsySQ7PVmbPC6g0
         AB3oZ+tfYiQn0T4ZQ1SaTdezo9LXbzJw+oj95vovJP0LqWxd+BTVDmBzibCUNH0mp168
         zVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694207233; x=1694812033;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWSOOTCDXcWLt+hpkQtfiADbPF+nA5H+PcCI5nxKBLM=;
        b=IPs48YEILsEy58zBhOCY0rGlIxAfxgLqUR5phzZctdcYe82XG8VX+Do5Xaj8Attfn4
         //2rO35aHExLZ7XgRbmT3PsopM3+AkIUzgB5eqQJhAWD1ZHyt7MZh4xMoGygL5r9NCo1
         5vc2FSAwlvd3FsBwSFRri+eP75NEdCCvCdBuUd9PzEYI9vD0AwzVUQ2G3GCXUjIhwTeO
         Ba6KrXDigDP6IdbY4mNMcY0+jMt2Ni+mkQcUaFzCCT3J0iU8qSh0daXWOCOlFiXXmXDX
         a4I6kb4cUiP3neI8oYSDWsR5c72/MHFiPD8ctC+hF837UjmNfZPgw1YEmqBnTdTXZvZY
         dM7w==
X-Gm-Message-State: AOJu0YwVBkWtJplsSToCUGDzUVXuyM3YPLCuOnEqTuVNaKutx6uWEreC
        gi1xM6/QoKXFjIvLI9FTeDuGZVZQGTFJuD9tpxbH/g==
X-Google-Smtp-Source: AGHT+IEDV5dRRxAbUxHF+XnQCGAiURCPHmu1SB2J2/xNgYCwvJczxaBanAsbo/HFVW9ks/VvlQTVf8Q2jl6WZK1ROAY=
X-Received: by 2002:a05:6808:181c:b0:3a7:1e86:e83f with SMTP id
 bh28-20020a056808181c00b003a71e86e83fmr4771241oib.51.1694207233538; Fri, 08
 Sep 2023 14:07:13 -0700 (PDT)
MIME-Version: 1.0
From:   Janet Miller <janet@fortunewebnetworks.com>
Date:   Fri, 8 Sep 2023 16:07:03 -0500
Message-ID: <CACjHo35YGBg=6yMVpjQOahr35qoSMXzzh+AtB1YS43vBJPS16Q@mail.gmail.com>
Subject: RE: AWS re:Invent Attendees Email list- 2023
To:     Janet Miller <janet@fortunewebnetworks.com>
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

Would you be interested in acquiring AWS re:Invent Attendees Data List 2023?

List contains: Company Name, Contact Name, First Name, Middle Name,
Last Name, Title, Address, Street, City, Zip code, State, Country,
Telephone, Email address and more,

No of Contacts: - 40,777
Cost: $1,977

Kind Regards,
Janet Miller
Marketing Coordinator
