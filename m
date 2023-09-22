Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA257AB51C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjIVPtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjIVPtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:49:47 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365B1122
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:49:41 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id ada2fe7eead31-452749f6c47so1065820137.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695397780; x=1696002580; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PaivhK/OUl6SqGjMgEqgjiRChHWeN2XZBrVW5gGwTZo=;
        b=mLQ7h8VxLeGrmPRDERJFxLyjSQKgXOkxmVM7XpjQFfVYnQJHd9pDVwa4ONn00j5WGm
         Jr4P5AvDMwh+tUKgz1lt125jWyQhHcV0LRxWipcWxL5t9+FeSnuCgpzGPGwrCXE2phzA
         2lL8atMMOlDr5jscWJNRdEhbz5tCy+pw0ClzmwBKbYrG57lLaRI2v7+yIBHCNRV1rtpc
         kgrY193nQakm+sUju901WJxpHJpr2qn9fmOqz6sMz9PAabnwSNBrYOMJbNXqeJ92jQaD
         gMhpm1+ktNuC7bV0UsUhaGOhlYzp7JSbxOYzb7ETemu+dI0cYGpP0CDS+nOHgo7pQQly
         HqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695397780; x=1696002580;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaivhK/OUl6SqGjMgEqgjiRChHWeN2XZBrVW5gGwTZo=;
        b=gN3zl6gGPFhwem/xzyC+VLEQagXc0nHq1KZe+p4QFyTrFP1kiFVzVaxnW4fCLO4Y10
         ou9Q3tdFqMWkYemwzbpZhJg4Wh/ddOg6t1HSa/SmWo722I7nBOp/nmJQe96NKh8Kw07e
         vftsJ698URQU2CLloYndSPAaytE+hv8fzwvb+33Ru7pW4rETUtXqakHpAvsQlWZu4pkW
         pAxwQEJqHhtV5B8DgNEFek83wFbez8fNEjSfW60OHDcgqL6NpP7dTDCFXLxcGoLfEzcY
         yh46vvMye/lEyy8JWF3yDf6Cf9EnmVh2kGQMQBkk3TjtQJnWTLW+x7PvX16CIOvbmG1x
         ZNUg==
X-Gm-Message-State: AOJu0YzzOMtc2s+27pyxQQB9PmbBTsQCkvN9Bgi40t65BOjpVlWXUw1K
        sYXI4JlbADEZg1Mi/dAo1T6hV2BTRYOJiAYfP3U=
X-Google-Smtp-Source: AGHT+IF+X1J3enBDUfJb+oIXP8MWlwexVbAmIF9ujqplpfA3gqOFbWkGJfEOjD81vGgMsckzzt+/iZdQ3/11C+rXt2M=
X-Received: by 2002:a67:fb02:0:b0:452:8dfc:4672 with SMTP id
 d2-20020a67fb02000000b004528dfc4672mr9107610vsr.4.1695397780207; Fri, 22 Sep
 2023 08:49:40 -0700 (PDT)
MIME-Version: 1.0
From:   Amanda Smith <smith.targetleadsprovider@gmail.com>
Date:   Fri, 22 Sep 2023 10:49:07 -0500
Message-ID: <CALAv7-8+18oMaCJikcKt5tvgL4qKXt695BmvkFQxpPBh=L_Rsg@mail.gmail.com>
Subject: Re: Black Hat Europe Registrants Attendees Email list- 2023
To:     Amanda Smith <smith.targetleadsprovider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring the Black Hat Europe Registrants
Attendees Email List-2023?

Our package includes a list of 10,986 attendees from the 2023 I Black
Hat Europe, including their contact information such as Company Name,
Contact Name, First Name, Middle Name, Last Name, Title, Address,
Street, City, Zip code, State, Country, Telephone, Email address, and
more.

Black Hat Europe Data package is available for $ 1,649.

Interested? Email me back; I would love to provide more information on the list.

Best regards,
Amanda Smith
