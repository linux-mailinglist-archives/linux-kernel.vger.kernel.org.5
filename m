Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241137F15E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjKTOkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjKTOk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:40:29 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A059A4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:40:22 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54373788ec4so1042371a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700491220; x=1701096020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VZWwPmFTj4avWRyhMjzlwlSPen+Xeyn/0Pd7E9frKUf0Ae0bz1eIDQojYJuPXQIVcb
         sYJ921b48OqGEnNUM6dnDtrhpIyUsnYDpcm4TxoE1qcDnrPpUqdwBqi8sGB9u8lk1T1w
         qPjOJ1dkTzX1p67n5FkPFqlrx9xmWD2VfhpvrRpqUDnx7W1gW26KG6v2KQxaxtjYkZ6N
         +U9WM2NYAqDKizzVIxemaGks61Yg221RS3cGbdPjB8S0FJhkRYqh53AhIlRmwIOOgwFJ
         I/DgXd2EkhEvlDYWfj0Q2Rd0pOJdp3LvvS3WCr4kqZ5h46ayqZJqNnyDVLGvpYdRIyaP
         Mo0Q==
X-Gm-Message-State: AOJu0Yz9A6vZ1H32r/l0b5LlPLKlh2aUdlY782grAGe2/8qHNK+9o/SI
        UNbTHDxwAMX9bsMxzSsJueA=
X-Google-Smtp-Source: AGHT+IG7DBCw0s55HSfLvfLvyJtR5hNJGd0DukOimwysJpxdwjL2RRiQyZHm7ju0v3+DMXm1hx8tGw==
X-Received: by 2002:aa7:c390:0:b0:543:6222:e37c with SMTP id k16-20020aa7c390000000b005436222e37cmr5178096edq.0.1700491220570;
        Mon, 20 Nov 2023 06:40:20 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w6-20020aa7d286000000b00548b96a52besm1158371edq.78.2023.11.20.06.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 06:40:20 -0800 (PST)
Message-ID: <7cf414f3-0e04-4031-a80b-194712c10008@grimberg.me>
Date:   Mon, 20 Nov 2023 16:40:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-keyring: add MODULE_LICENSE()
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        linux-nvme@lists.infradead.org
References: <20231023230052.31161-1-rdunlap@infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231023230052.31161-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
