Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD7C7831A0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjHUTv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHUTvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:51:55 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC452FB;
        Mon, 21 Aug 2023 12:51:49 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1bf62258c4dso11296015ad.2;
        Mon, 21 Aug 2023 12:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647508; x=1693252308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8CBJ63cjV+sJ8R1OQRGZ+key9gcGCvoYCJAYk4zDWM=;
        b=cVu6BWnyQJRTWC0/h88Y6Citcdu81mRC2Hu7gWI98oQssG34OSGNpcLelHIR74c4g7
         1sI/jQ2owsy+pdWn9i1K3WCfkAA7HC95VE1z+PD7BrQSTubw1BYbR8E3mLFpSl1aYay8
         BQxK6fRrUEtXlcvGQW3nB/IXHUUmwPDmOrd+8bgdv5brr+2AKiXBXxIW+0FsenwwK+69
         8GUmqGUXd+gcRxX5FoXLL079OkOJiEG79XOlI40s00mnCK7E7Kz4Aaij3JYXeS3Onepp
         xMbeLR6hPAJzi6CQDNM8Cu6EpgpD1ZcVTSyWU6XP4MP580LWRdX8b5egRJc3hpHDLv/D
         Jh7Q==
X-Gm-Message-State: AOJu0YxzDDtNmWzqzcdzL7+L9Kg0dLMox1Tr0CXZh6QX7nD9KiwHwtKn
        1XgYMNyRXQYtOsk1kMtJedc=
X-Google-Smtp-Source: AGHT+IGgZcWk8B+dqH1Io20kRBwIjPYbBJXqCXNsTNtCXp7V8m/4CNxClHt23uRvUZBDwe0ZfNxWOw==
X-Received: by 2002:a17:902:ea11:b0:1bd:f69e:6630 with SMTP id s17-20020a170902ea1100b001bdf69e6630mr7576684plg.65.1692647508532;
        Mon, 21 Aug 2023 12:51:48 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ef58:6534:ec7a:8ab2? ([2620:15c:211:201:ef58:6534:ec7a:8ab2])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001beef2c9bffsm7402546plz.85.2023.08.21.12.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 12:51:48 -0700 (PDT)
Message-ID: <0f957502-bcb4-9fdd-66e8-3ee92c958f99@acm.org>
Date:   Mon, 21 Aug 2023 12:51:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH -next] scsi: pm8001: Remove unused declarations
Content-Language: en-US
To:     Yue Haibing <yuehaibing@huawei.com>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        john.garry@huawei.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230818124700.49724-1-yuehaibing@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230818124700.49724-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/23 05:47, Yue Haibing wrote:
> Commit 4fcf812ca392 ("[SCSI] libsas: export sas_alloc_task()")
> removed these implementations but not the declarations.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
