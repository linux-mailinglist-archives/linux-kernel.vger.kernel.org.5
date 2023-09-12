Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EC579DC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjILXVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjILXVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:21:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7B510FF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 16:21:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d71f505d21dso6005310276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 16:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694560862; x=1695165662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2yKiL7UrV2W3oIuzSuDJKbrYeZQM4aEB+p2LpmA+bo=;
        b=A3HB32qVCzbWciZ78THZjZtpmvzEFvFBzZ5EHbPH0qA2mdVwX+eWHqFJj14fUBLn7i
         h4yqrOKzUECrjujMcHDCEoaM7H5tNKiK58DaICxIp/aiBcnORvkHBmAc6hC3TvWP/ebV
         +LP4elSGiXl1WY/iB7Qub239RxY8eHMcXugdYPwiTA825i41nftT/MJdCKhyM0bLKfKo
         zAJ3bVBu45VDsxq9nMR2R7t52cHjy57Rmh/uTkKoDadqjZjNngb9TvAFUyOHxLsldlZX
         HJ5o6Uqvybdfy5Jk2el1URwaYA81yOJKmuejFARqtyAPJoToI7BQtN/Yw1tisUhorU7d
         P0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694560862; x=1695165662;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2yKiL7UrV2W3oIuzSuDJKbrYeZQM4aEB+p2LpmA+bo=;
        b=rWNTIPtAvLxnt41s55huh1MuPf5EFGgD2GqNAjz/IPXceOz+lDOtyVuPU7q4qUqK3x
         9qE8gIYhVfRywGDaz446ZiOPAPW0IgRTXL9txbPZxmKqIWDDiuhFbHksRwGAWDmqyBrU
         T/wWXg5Qw3eJCNxoonKVAtgNxT9NvwxUqAnTWIwpSiADwJz5dSnb/plT6LXCJOc48bnS
         vvUEA8laMJ+fiqR9mPibzdWNBw6F+GBz+oblHRDQqrKdJxI+yFN4rmexbjjJlaoq61oz
         ttfn5SyYkrp8nAqcHY9BP9dHxK6cmGFiZTbFuL/VsQuVKIrCYyKf5QMp1bZYKrnMrW4y
         c2rw==
X-Gm-Message-State: AOJu0YyfX+OlgmHr4o112EgF6vK57hlR0WXgORMT+bDnoaNQD8XSZ9Nt
        TI+h5g84EjEtdU0TEE8F7vzhxCuEj0M=
X-Google-Smtp-Source: AGHT+IF1nwbYw+IIssLcKJz517xhldsLguhjQH9pf6FLI9hZKsAh6/s6tYOSEahOAxjNyYtc9753QskwCpA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:481:0:b0:d7a:bd65:18ba with SMTP id
 n1-20020a5b0481000000b00d7abd6518bamr20096ybp.3.1694560862708; Tue, 12 Sep
 2023 16:21:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 12 Sep 2023 16:21:00 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912232100.978817-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2023.09.13 - CANCELED
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Canceling this week.  I will get v12 of the guest_memfd() series posted
tomorrow (it's more or less ready, need to test and capture the remaining work).
